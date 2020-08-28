import 'package:flutter/material.dart';

class ButtonTile extends StatelessWidget {
  String label;
  ButtonTile(String lable) {
    label = lable;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: label == 'Clear'
              ? Colors.cyan
              : label == 'Save'
                  ? Colors.blue
                  : (int.tryParse(label) == null)
                      ? Colors.green
                      : Color(0xff1CA7FF),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
