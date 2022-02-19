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

  void evaluateLetter({String? result, String? ref}) {

    setState(() {
      if (result == 'found') {
        mapSquareDecoration[ref!] = letterDecorationFoundRightPosition;
      }
      if (result == 'notFound') {
        mapSquareDecoration[ref!] = letterDecorationNotFound;
      }
      if (result == 'wrongPosition') {
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
      body:
      Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.grey[800],
        child: Column(
          children: [
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

            // Buttons
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () =>
                       evaluateLetter(result: 'notFound', ref:'25'),
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
                        evaluateLetter(result: 'wrongPosition', ref:'25'),
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
                        evaluateLetter(result:'found', ref:'12'),
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
          ],

        ),
      ),

    );
  }
}
