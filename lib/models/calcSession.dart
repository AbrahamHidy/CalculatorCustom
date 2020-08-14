import 'package:calculator_custom/models/calculation.dart';
import 'package:flutter/material.dart';

class CalcSession extends ListView {
  String name;
  DateTime timecreated;
  DateTime lastEdited;
  List<Calculation> calculations = new List();

  CalcSession({
    this.name,
    this.timecreated,
    this.lastEdited,
  }) : super();
}
