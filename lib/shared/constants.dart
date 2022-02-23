import 'package:flutter/material.dart';

// Decoration of the letter containers
// -----------------------------------

// Letter not found
BoxDecoration letterDecorationNotFound = BoxDecoration(
    color: Colors.grey[600],
    border: Border.all(
      color: Colors.grey,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(12)
);

// Letter not found in the right position
BoxDecoration letterDecorationFoundWrongPosition = BoxDecoration(
    color: Colors.orange,
    border: Border.all(
      color: Colors.grey,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(12)
);


// Letter found in the right position
BoxDecoration letterDecorationFoundRightPosition = BoxDecoration(
    color: Colors.green,
    border: Border.all(
      color: Colors.grey,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(12)
);

// Variables related to the state and content of the squares
// ---------------------------------------------------------

Map<String,String> mapLetterValue = {

  '11': '',
  '12': '',
  '13': '',
  '14': '',
  '15': '',

  '21': '',
  '22': '',
  '23': '',
  '24': '',
  '25': '',

  '31': '',
  '32': '',
  '33': '',
  '34': '',
  '35': '',


  '41': '',
  '42': '',
  '43': '',
  '44': '',
  '45': '',

  '51': '',
  '52': '',
  '53': '',
  '54': '',
  '55': '',

  '61': '',
  '62': '',
  '63': '',
  '64': '',
  '65': '',

};


Map<String,BoxDecoration> mapSquareDecoration = {
  '11': letterDecorationNotFound,
  '12': letterDecorationNotFound,
  '13': letterDecorationNotFound,
  '14': letterDecorationNotFound,
  '15': letterDecorationNotFound,

  '21': letterDecorationNotFound,
  '22': letterDecorationNotFound,
  '23': letterDecorationNotFound,
  '24': letterDecorationNotFound,
  '25': letterDecorationNotFound,

  '31': letterDecorationNotFound,
  '32': letterDecorationNotFound,
  '33': letterDecorationNotFound,
  '34': letterDecorationNotFound,
  '35': letterDecorationNotFound,

  '41': letterDecorationNotFound,
  '42': letterDecorationNotFound,
  '43': letterDecorationNotFound,
  '44': letterDecorationNotFound,
  '45': letterDecorationNotFound,

  '51': letterDecorationNotFound,
  '52': letterDecorationNotFound,
  '53': letterDecorationNotFound,
  '54': letterDecorationNotFound,
  '55': letterDecorationNotFound,

  '61': letterDecorationNotFound,
  '62': letterDecorationNotFound,
  '63': letterDecorationNotFound,
  '64': letterDecorationNotFound,
  '65': letterDecorationNotFound,

};


