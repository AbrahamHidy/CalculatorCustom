import 'package:flutter/material.dart';

class WidgetProider {
  TextStyle buttonTextStyle() {
    return TextStyle(
      fontSize: 20,
      color: Colors.white,
    );
  }

  InputDecoration formInputdecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.black),
      focusedBorder: UnderlineInputBorder(),
    );
  }
}
