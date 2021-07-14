import 'package:flutter/material.dart';

var kLabelText = TextStyle(color: Colors.white);
var ktfDecoration = BoxDecoration(
    color: Colors.blue[800],
    borderRadius: BorderRadius.circular(5),
    boxShadow: [
      BoxShadow(offset: Offset(2, 2), blurRadius: 10, color: Colors.white30)
    ]);

var kGradientboxDecoration = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
      Colors.blue[900],
      Colors.blue[800],
      Colors.blue[700],
      Colors.blue[600]
    ]));
