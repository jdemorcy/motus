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

  bool status = false;
  String letter = 'P';

  void changeLetter() {
    setState(() {
      letter = 'V';
      status = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.title,
          style: const TextStyle(
            fontSize: 60.0,
          ),
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[Container(
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.topCenter,
          color: Colors.black,
          child: Container(
            width: 60.0,
            height: 70.0,
            padding: EdgeInsets.all(10.0),
            decoration: status ? letterDecorationFound : letterDecorationNeutral,
            child: Text(
              letter,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),

          ElevatedButton(
            onPressed: () => changeLetter(),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey)
            ),
            child: const Text(
              'Update',
            ),
          ),
        ]
      ),
    );
  }
}
