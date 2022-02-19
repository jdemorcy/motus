import 'package:flutter/material.dart';

// Decoration of the letter containers

// Letter not found
BoxDecoration letterDecorationNotFound = BoxDecoration(
    color: Colors.grey[600],
    border: Border.all(
      color: Colors.grey,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(12)
);

// Letter not found
BoxDecoration letterDecorationFoundWrongPosition = BoxDecoration(
    color: Colors.red,
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