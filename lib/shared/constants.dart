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

// Form field decoration
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2.0),
  ),
);

// Variables related to the state and content of the squares
// ---------------------------------------------------------

// Object used to populate maps which hold grid default values
class VariablesInitializer {
  Map<String,BoxDecoration> mapSquares = {};
  Map<String,String> mapLetters = {};
  String index = '';

  VariablesInitializer() {
    for(var j=1; j<7; j++) {
      for (var i=1; i<6; i++) {
        // Squares are addressed through a composite index: #row #col
        index = j.toString() + i.toString();
        mapSquares[index] = letterDecorationNotFound; // Set default square decoration to "letter not found"
        mapLetters[index] = ''; // Set default square content to ''
      }
    }
  }
}

VariablesInitializer init = VariablesInitializer();
Map<String,BoxDecoration> mapSquareDecoration = init.mapSquares; // Square decoration
Map<String,String> mapLetterValue = init.mapLetters; // Square content
