import 'package:flutter/material.dart';
import 'package:motus/shared/constants.dart';

class RowBuilder extends StatelessWidget {

  String ref;

  RowBuilder({required this.ref});

  @override
  Widget build(BuildContext context) {
    print('grid builder ran');
    return Container(
      width: 60.0,
      height: 60.0,
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
      decoration: mapSquareDecoration[ref],
      child: Text(
        mapLetterValue[ref]!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 40.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
