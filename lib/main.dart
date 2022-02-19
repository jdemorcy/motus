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

  BoxDecoration status = letterDecorationNotFound;

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


  void evaluateLetter({String? res, int? index}) {

    setState(() {
      if(res == 'found') status = letterDecorationFoundRightPosition;
      if(res == 'notFound') status = letterDecorationNotFound;
      if(res == 'wrongPosition') status = letterDecorationFoundWrongPosition;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
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
              decoration: status,
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
                decoration: status,
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
                decoration: status,
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
                decoration: status,
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
                decoration: status,
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
                onPressed: () => evaluateLetter(res: 'notFound', index: 1),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey)
                ),
                child: const Text(
                  'Not Found',
                ),
              ),
              SizedBox(width: 20.0),

              ElevatedButton(
                onPressed: () => evaluateLetter(res: 'wrongPosition', index: 1),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey)
                ),
                child: const Text(
                  'Wrong',
                ),
              ),
              SizedBox(width: 20.0),

              ElevatedButton(
                onPressed: () => evaluateLetter(res: 'found', index: 1),
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
