import 'package:flutter/material.dart';
import 'package:motus/tools/row_builder.dart';
import 'package:motus/tools/form_builder.dart';

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

  // Function used to draw the form
  Widget printForm() {
    return FormBuilder();
  }

  // Function used to draw the grid (one row at a time)
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
    print('main builder ran');
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        /*
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
         */
        print('tapped !');
        currentFocus.unfocus();
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
                printForm(),

              SizedBox(height: 20.0),

              // GRID

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