import 'package:flutter/material.dart';

class Calculation {
  String _result;
  String _expression;
  Color color;
  DateTime timeCreated = DateTime.now();

  Calculation(this._result, this._expression);

  String getResult() {
    return this._result;
  }

  String getExpression() {
    return this._expression;
  }
}
