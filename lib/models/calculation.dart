import 'package:flutter/material.dart';

class Calculation extends ListTile {
  String name;
  String content;
  Color color;
  DateTime timeCreated;

  Calculation({
    this.name,
    this.content,
    this.color,
    this.timeCreated,
  }) : super();
}
