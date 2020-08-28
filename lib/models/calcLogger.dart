import 'package:calculator_custom/models/calculation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CalcLogger {
  List<Widget> _savedCalcs = [];
  DateTime _timeCreated = DateTime.now();

  void saveCalculation(Calculation calcToSave) {
    _savedCalcs.insert(
      0,
      Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              child: Text((_savedCalcs.length + 1).toString()),
              foregroundColor: Colors.white,
            ),
            title: Text(calcToSave.getResult()),
            subtitle: Text(calcToSave.getExpression()),
          ),
        ),
        secondaryActions: [
          IconSlideAction(
            caption: 'Info',
            color: Colors.blue,
            icon: Icons.info,
            onTap: () => null, // IMPLEMENT info pane
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => null, // IMPLEMENT info pane
          ),
        ],
      ),
    );
  }

  int getLength() {
    return _savedCalcs.length;
  }

  List<Widget> getLoggedCalcs() {
    return _savedCalcs;
  }
}
