import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:motus/shared/constants.dart';
import 'package:firebase/firebase_io.dart';
import 'dart:math';

class FormBuilder extends StatefulWidget {

  const FormBuilder({Key? key}) : super(key: key);

  @override
  _FormBuilderState createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {

  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Current player try (1 - 6)
  int tryNum = 1;
  // Check whether player has won or not
  bool playerHasWon = false;
  // Word to be found (capitalized)
  String wordAllCaps = '';
  // Word to be found (small cap with accents)
  String wordSmallCaps = '';
  // Wikitionnaire url
  String wikiUrl = 'https://fr.wiktionary.org/wiki';
  // Player proposition
  String proposition = '';
  // Form field controller
  TextEditingController myController = TextEditingController();
  // Object used to control the focus on the form field and thus the display of the keyboard
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    // Adding a listener to the form field to detect any changes and check the length of the field text
    myController.addListener(checkInputField);
    // Object used to control the focus on the form field and thus the display of the keyboard
    myFocusNode = FocusNode();
    // Getting first word
    getWordToFind();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  Future<void> getWordToFind() async {
    print('-- getWordToFind ran');
    FirebaseClient fbClient = FirebaseClient.anonymous();
    Map<String,dynamic> response;
    String path;

    // Getting number of words available from the param collection
    path = 'https://motus-12db3-default-rtdb.europe-west1.firebasedatabase.app/param.json';
    response = await fbClient.get(path);
    int count = response['count'];
    print('# of words: $count');

    // Generating random number
    Random random = Random();
    int randomNumber = random.nextInt(count-1) + 1; // from 1 to count

    path = 'https://motus-12db3-default-rtdb.europe-west1.firebasedatabase.app/words/$randomNumber/word.json';
    response = await fbClient.get(path);

    response.forEach((key, value) {
      wordAllCaps = key;
      wordSmallCaps = value;
    });

    print('random word #$randomNumber: $wordAllCaps');
  }

  void checkInputField() {
    // Checking form field input length to prevent player to type more than 5 characters
    // Function is triggered every time the content of the form field changes
    if(myController.text.length > 5) {
      myController.text = myController.text.substring(0,5);
      setState(() {
        _showInSnackBar("Proposition must be 5 (alphabetic) characters long (accented characters are not allowed) !");
      });
    }
  }

  Future<void> formValidation() async {
    // Validation of the content of the form field
    var reg = RegExp(r'^[a-zA-Z]{5}$');
    // We first check that form field input is valid
    if(myController.text.length != 5 || !reg.hasMatch(myController.text)) {
      setState(() {
        _showInSnackBar("Proposition must be 5 (alphabetic) characters long (accented characters are not allowed) !");
      });
    } else {
      // We then check that player proposition is a valid word
      FirebaseClient fbClient = FirebaseClient.anonymous();
      Map<String, dynamic> response = {};
      proposition = myController.text.toUpperCase();
      String wordToBeChecked = proposition;
      var path = 'https://motus-12db3-default-rtdb.europe-west1.firebasedatabase.app/check/$wordToBeChecked.json';

      response = await fbClient.get(path) ?? response;
      if(response.isEmpty) {
        // If the proposed word has not been found in the DB
        print('Word: $wordToBeChecked has not been found !');
        setState(() {
          _showInSnackBar("Proposition must be an existing word !");
        });
      } else {
        // If the proposed word has been found in the DB -> proceed to the full check
        print('Word $wordToBeChecked has been found ! ${response}');
        myController.text = '';
        myFocusNode.unfocus();
        checkResult();
      }
    }
  }

  void _showInSnackBar(message) {
    // Displaying messages to the player in a SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
        Text(
          message,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        duration: (Duration(seconds: 3)),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
    );
  }

  void checkResult() {

    // Procedure used to compare two words and to give ths status of the different letters
    // ***********************************************************************************

    // Procedure build a result variable containing an evaluation of every square:
    // OK (letter found) - MP (letter misplaced) - KO (letter not found)

    // Initialization of variables
    // ---------------------------

    bool _debug = false; // Activation of the debug of the procedure in the console

    int numOKLetters = 0; // number of well-placed letters (used to determine if player has won)

    List<String> wordLettersList = []; // List used to store each letters of the word to be found
    List<String> propositionLettersList = []; // List used to store each letters of the player proposition
    List<String> result = []; // List which will hold the results of the comparison process

    // Creating lists of letters which can be compared
    wordLettersList = wordAllCaps.split("");
    propositionLettersList = proposition.split("");


    // Comparison process
    // ------------------

    List ctrlWordLettersList = wordLettersList.sublist(0); // Working copy of the word list
    List ctrlPropositionLettersList = propositionLettersList.sublist(0); // Working copy of the word list

    // First iteration: looking for exact matches between word and proposition and remove them from the scope of the search
    for(var i=0; i < wordLettersList.length; i++) {
      result.add("?"); // Initialisation of the list of results with default values
      if(ctrlWordLettersList[i] == ctrlPropositionLettersList[i]) { // if exact match...
        ctrlWordLettersList[i] =  ctrlPropositionLettersList[i] = "!"; // ...then remove from ths scope of the search
        result[i] = "OK";
        numOKLetters++;
      }
    }

    // Second iteration: looking for misplaced or wrong letters in the proposition
    for(var i=0; i < wordLettersList.length; i++) {
      if(ctrlPropositionLettersList[i] != "!") { // Making sure the current letter has not been marked as an exact match in iteration 1
        if(ctrlWordLettersList.contains(ctrlPropositionLettersList[i])) { // if current letter is misplaced...
          ctrlWordLettersList[ctrlWordLettersList.indexOf(ctrlPropositionLettersList[i])] = "!"; // ...then marking the case as "treated"
          result[i] = "MP";
        } else {
          result[i] = "KO";
        }
      }
    }

    // Displaying process result in console
    // ------------------------------------
    if(_debug) {
      print("");
      print("Word to be found: $wordLettersList");
      print("Player proposition: $propositionLettersList");
      print("");
      print("");
      print("RESULTS");
      print("\t\t #1 \t #2 \t #3 \t #4 \t #5");
      print(
          "Word\t\t ${wordLettersList[0]} \t ${wordLettersList[1]} \t ${wordLettersList[2]} \t ${wordLettersList[3]} \t ${wordLettersList[4]}");
      print("\t\t | \t | \t | \t | \t |");
      print(
          "Proposition\t ${propositionLettersList[0]} \t ${propositionLettersList[1]} \t ${propositionLettersList[2]} \t ${propositionLettersList[3]} \t ${propositionLettersList[4]}");
      print("\t\t | \t | \t | \t | \t |");
      print(
          "Result\t\t ${result[0]} \t ${result[1]} \t ${result[2]} \t ${result[3]} \t ${result[4]}");
      print("");
    }

    // Decorating squares after results calculation
    playerHasWon = (numOKLetters == 5) ? true : false;
    decorateSquare(result, propositionLettersList);

  }

  void decorateSquare(result, propositionLettersList) {

    print('decorate_square ran');
    print("focus: ${FocusManager.instance.primaryFocus}");

    // Function used to decorate the squares after the evaluation of the proposition of the player

    String index;

    setState(() { // Forces the widget to be rebuilt

      for(var i=0; i<5; i++) {

        // Squares are addressed through a composite index: #row #col
        index = tryNum.toString() + (i+1).toString();

        // Printing the letter in the square
        mapLetterValue[index] = propositionLettersList[i];

        // Adding proper decoration to the square
        // OK (letter found) - MP (letter misplaced) - KO (letter not found)
        if (result[i] == 'OK') {
          mapSquareDecoration[index] = letterDecorationFoundRightPosition;
        }
        if (result[i] == 'KO') {
          mapSquareDecoration[index] = letterDecorationNotFound;
        }
        if (result[i] == 'MP') {
          mapSquareDecoration[index] = letterDecorationFoundWrongPosition;
        }

      }

      tryNum++;

    });

    // Showing Dialog in case of win or loss
    if(playerHasWon || (tryNum > 6) ) {
      showAlertDialog(context);
    }

  }

  showAlertDialog(BuildContext context) {

    // set up the wikitionnaire button
    Widget wikiButton = TextButton(
      child: Text("Show word def. in wikitionnaire"),
      onPressed: () async {
          var url = Uri.encodeFull('$wikiUrl/$wordSmallCaps');
          await launch(url); // required a modification in AndroidManifest.xml in order to work
        },
    );

    // set up the ok button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        // Dismiss the alert Dialog
        Navigator.of(context, rootNavigator: true).pop();
        // Initiate new game
        newGame();
      },
    );

    // set up the AlertDialog for winners
    AlertDialog alertPlayerWins = AlertDialog(
      title: Text("Good job !"),
      content: Text("You found it ! $wordAllCaps ($wordSmallCaps) was the word ! \n\nClick on the 'OK' button to start a new game."),
      actions: [
        wikiButton, okButton,
      ],
    );

    // set up the AlertDialog for losers
    AlertDialog alertPlayerLoses = AlertDialog(
      title: Text("Well..."),
      content: Text("The word you were looking for was: $wordAllCaps ($wordSmallCaps)... \n\nClick on the 'OK' button to start a new game."),
      actions: [
        wikiButton, okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return playerHasWon ? alertPlayerWins : alertPlayerLoses;
      },
    );
  }

  // Start a new game
  newGame() {
    print('new game initialization');

    // Reinitialization of game variables
    tryNum = 1;
    playerHasWon = false;

    // Picking a new word
    getWordToFind();

    // Cleaning up the grid
    setState(() { // Forces the widget to be rebuilt
      String index;
      for(var j=1; j<7; j++) {
        for (var i=1; i<6; i++) {
          // Squares are addressed through a composite index: #row #col
          index = j.toString() + i.toString();
          mapSquareDecoration[index] = letterDecorationNotFound;
          mapLetterValue[index] = '';
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    print('form builder ran');
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200.0,
                child: Container(
                  child: TextFormField( // Proposition
                    focusNode: myFocusNode,
                    decoration: textInputDecoration.copyWith(hintText: ''),
                    controller: myController,
                  ),
                ),
              ),

              SizedBox(width: 20.0),

              ElevatedButton(
                onPressed: () {
                  formValidation();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.blueGrey)
                ),
                child: const Text(
                  'Check',
                  style: TextStyle(
                      fontSize: 12.0
                  ),
                ),
              ),

            ]),
      ),
    );
  }
}
