import 'package:flutter/material.dart';

// Currently unnecessary. Is implemented in calcPage. Later maybe move it here.

class DrawerItem extends StatefulWidget {
  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListTile(
          title: Text(
            "Test 1",
            style: TextStyle(fontSize: 20),
          ),
          focusColor: Colors.blue,
        ),
        FlatButton(
          child: Icon(Icons.delete),
          onPressed: () {},
        )
      ],
    );
  }
}
