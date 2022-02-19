import 'package:flutter/material.dart';
import 'package:motus/shared/constants.dart';

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

  String letter1 = '';
  String letter2 = '';
  String letter3 = '';
  String letter4 = '';
  String letter5 = '';

  Map<String,String> mapLetters = {
    'letter_1': "L",
    'letter_2': "A",
    'letter_3': "P",
    'letter_4': "I",
    'letter_5': "N",
  };

  Map<String,BoxDecoration> mapLettersDecoration = {
    'letter_1': letterDecorationNotFound,
    'letter_2': letterDecorationNotFound,
    'letter_3': letterDecorationNotFound,
    'letter_4': letterDecorationNotFound,
    'letter_5': letterDecorationNotFound,
  };


  void evaluateLetter({String? res, String? target}) {
    setState(() {
      if(res == 'found') mapLettersDecoration[target!] = letterDecorationFoundRightPosition;
      if(res == 'notFound') mapLettersDecoration[target!] = letterDecorationNotFound;
      if(res == 'wrongPosition') mapLettersDecoration[target!] = letterDecorationFoundWrongPosition;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
      body: Column(
        children: <Widget>[
          Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Letter #1
              Container(
              width: 60.0,
              height: 60.0,
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
              decoration: mapLettersDecoration['letter_1'],
              child: Text(
                mapLetters['letter_1']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
              SizedBox(width: 10.0),

              // Letter #2
              Container(
                width: 60.0,
                height: 60.0,
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                decoration: mapLettersDecoration['letter_2'],
                child: Text(
                  mapLetters['letter_2']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10.0),

              // Letter #3
              Container(
                width: 60.0,
                height: 60.0,
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                decoration: mapLettersDecoration['letter_3'],
                child: Text(
                  mapLetters['letter_3']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10.0),

              // Letter #4
              Container(
                width: 60.0,
                height: 60.0,
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                decoration: mapLettersDecoration['letter_4'],
                child: Text(
                  mapLetters['letter_4']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10.0),

              // Letter #5
              Container(
                width: 60.0,
                height: 60.0,
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                decoration: mapLettersDecoration['letter_5'],
                child: Text(
                  mapLetters['letter_5']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
        SizedBox(height: 20.0),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => evaluateLetter(res: 'notFound', target: 'letter_2'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey)
                ),
                child: const Text(
                  'Not Found',
                ),
              ),
              SizedBox(width: 20.0),

              ElevatedButton(
                onPressed: () => evaluateLetter(res: 'wrongPosition', target: 'letter_2'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey)
                ),
                child: const Text(
                  'Wrong',
                ),
              ),
              SizedBox(width: 20.0),

              ElevatedButton(
                onPressed: () => evaluateLetter(res: 'found', target: 'letter_2'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey)
                ),
                child: const Text(
                  'Found',
                ),
              ),
          ]
          ),
        ]
      ),
    );
  }
}
