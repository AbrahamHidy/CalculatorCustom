import 'package:calculator_custom/models/calculation.dart';
import 'package:flutter/material.dart';

class CalcSession {
  String name;
  DateTime timecreated;
  DateTime lastEdited;
  List<Calculation> calculations = new List();
}
