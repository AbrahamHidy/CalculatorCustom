import 'package:flutter/material.dart';

class DrawerItem extends StatefulWidget {
  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Test 1",
        style: TextStyle(fontSize: 20),
      ),
      focusColor: Colors.blue,
    );
  }
}
