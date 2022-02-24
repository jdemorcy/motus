import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:motus/shared/constants.dart';
import 'package:motus/tools/row_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motus',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Motus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Current try
  int tryNum = 1;

  String proposition = '';

  // Form related variables
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String message = '';
  final myController = TextEditingController();
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myController.addListener(checkInputField);

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();

    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  checkInputField() {
    // Checking form field input length to prevent player to type more than 5 characters
    if(myController.text.length > 5) {
      myController.text = myController.text.substring(0,5);
      setState(() {
        _showInSnackBar("Proposition must be 5 (alphabetic) characters long !");
      });
    }
  }

  formValidation() {
    var reg = RegExp(r'^[a-zA-Z]{5}$');
    if(myController.text.length != 5 || !reg.hasMatch(myController.text)) {
      setState(() {
        _showInSnackBar("Proposition must be 5 (alphabetic) characters long !");
      });
    } else {
      proposition = myController.text.toUpperCase();
      myController.text = '';
      myFocusNode.unfocus();
      checkResult();
    }

  }

  void _showInSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GestureDetector(
          onTap: () {},
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        duration: (Duration(seconds: 4)),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
    );
  }



  void evaluateLetter({String? result, String? ref}) {

    setState(() {
      if (result == 'OK') {
        mapSquareDecoration[ref!] = letterDecorationFoundRightPosition;
      }
      if (result == 'KO') {
        mapSquareDecoration[ref!] = letterDecorationNotFound;
      }
      if (result == 'MP') {
        mapSquareDecoration[ref!] = letterDecorationFoundWrongPosition;
      }

    });

  }

  List<Widget> printRow({int? rowNum}) {
    var lst = <Widget>[];
    var ref;

    for(var i=1; i<=5; i++) {
      ref = rowNum.toString() + i.toString();
      lst.add(RowBuilder(ref: ref));
    }

    return lst;
  }

  checkResult() {

    // Procedure used to compare two words and to give ths status of the different letters
    // ***********************************************************************************


    // Initialization of variables
    // ---------------------------

    String word = "nepal".toUpperCase();

    List<String> wordLettersList = []; // List used to store each letters of the word to be found
    List<String> propositionLettersList = []; // List used to store each letters of the player proposition
    List<String> result = []; // List which will hold the results of the comparison process

    // Creating lists of letters which can be compared
    wordLettersList = word.split("");
    propositionLettersList = proposition.split("");

    print("");
    print("Word to be found: $wordLettersList");
    print("Player proposition: $propositionLettersList");

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
      }
    }

    // Second iteration: looking for misplaced or wrong letters in the proposition
    for(var i=0; i < wordLettersList.length; i++) {
      if(ctrlPropositionLettersList[i] != "!") { // Making sure the current letter has not been marked as an exact macth in iteration 1
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

    print("");
    print("RESULTS");
    print("\t\t #1 \t #2 \t #3 \t #4 \t #5");
    print("Word\t\t ${wordLettersList[0]} \t ${wordLettersList[1]} \t ${wordLettersList[2]} \t ${wordLettersList[3]} \t ${wordLettersList[4]}");
    print("\t\t | \t | \t | \t | \t |");
    print("Proposition\t ${propositionLettersList[0]} \t ${propositionLettersList[1]} \t ${propositionLettersList[2]} \t ${propositionLettersList[3]} \t ${propositionLettersList[4]}");
    print("\t\t | \t | \t | \t | \t |");
    print("Result\t\t ${result[0]} \t ${result[1]} \t ${result[2]} \t ${result[3]} \t ${result[4]}");
    print("");

    // Decorating squares after results calculation
    decorateSquare(result, propositionLettersList);

  }

  decorateSquare(result, propositionLettersList) {

    // Function used to decorate the squares after check

    String index;

    setState(() {

      for(var i=0; i<5; i++) {

        index = tryNum.toString() + (i+1).toString();

        mapLetterValue[index] = propositionLettersList[i];

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

  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 50.0,
            ),
          ),
          elevation: 0.0,
        ),
          body: Container(
            color: Colors.grey[800],
            padding: const EdgeInsets.all(10.0),

            child: Column(
              children: [
                // FORM
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Form(
                  key: _formKey,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    SizedBox(
                      width: 250.0,
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
                        'Check !',
                        style: TextStyle(
                          fontSize: 18.0
                        ),
                      ),
                    ),

                  ]),
              ),
                ),

              SizedBox(height: 20.0),

              // Grid

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: printRow(rowNum: 1),
                ),

                SizedBox(height: 20.0),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: printRow(rowNum: 2),
                ),

                SizedBox(height: 20.0),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: printRow(rowNum: 3),
                ),

                SizedBox(height: 20.0),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: printRow(rowNum: 4),
                ),

                SizedBox(height: 20.0),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: printRow(rowNum: 5),
                ),

                SizedBox(height: 20.0),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: printRow(rowNum: 6),
                ),

              ]),

          ),


      ),
    );
  }
}

/*
Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.grey[800],
        child: Column(
          children: [
            // Input form field
            Row(
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20.0, width: 300.0),
                        TextFormField( // email
                          decoration: textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                        ),
                      ],
                    ),

                )

              ]

            ),

            // Grid
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: printRow(rowNum: 1),
            ),

            SizedBox(height: 20.0),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: printRow(rowNum: 2),
            ),

            SizedBox(height: 20.0),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: printRow(rowNum: 3),
            ),

            SizedBox(height: 20.0),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: printRow(rowNum: 4),
            ),

            SizedBox(height: 20.0),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: printRow(rowNum: 5),
            ),

            SizedBox(height: 20.0),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: printRow(rowNum: 6),
            ),

            SizedBox(height: 20.0),


            ElevatedButton(
              onPressed: (tryNum < 7) ? checkResult : null,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.blueGrey)
              ),
              child: const Text(
                'Check',
              ),
            ),

          ],

        ),
      ),
 */



/*
// Buttons
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () =>
                       evaluateLetter(result: 'KO', ref:'14'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.blueGrey)
                    ),
                    child: const Text(
                      'Not Found',
                    ),
                  ),
                  SizedBox(width: 20.0),

                  ElevatedButton(
                    onPressed: () =>
                        evaluateLetter(result: 'MP', ref:'14'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.blueGrey)
                    ),
                    child: const Text(
                      'Wrong',
                    ),
                  ),
                  SizedBox(width: 20.0),

                  ElevatedButton(
                    onPressed: () =>
                        evaluateLetter(result:'OK', ref:'12'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.blueGrey)
                    ),
                    child: const Text(
                      'Found',
                    ),
                  ),
                ]
            ),
 */
