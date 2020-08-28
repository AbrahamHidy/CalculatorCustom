import 'package:calculator_custom/models/calculation.dart';
import 'package:flutter/material.dart';

// Can be remover; replaced by calcLogger.

class CalcSession extends ListView {
  String name;
  DateTime timecreated;
  DateTime lastEdited;
  List<Calculation> calculations = new List();

  CalcSession(String name, DateTime timeCreated, DateTime lastEdited)
      : super() {
    this.name = name;
    this.timecreated = timeCreated;
    this.lastEdited = lastEdited;
  }
}
