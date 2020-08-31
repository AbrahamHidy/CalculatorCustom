import 'package:calculator_custom/models/calculation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CalcLogger {
  List<Widget> _savedCalcs = [];
  List<Calculation> _calcsForReference = [];
  String _name;
  String _id;
  DateTime timeCreated = DateTime.now();
  final Function notifyParent;

  CalcLogger({Key key, @required this.notifyParent});

  void saveCalculation(Calculation calcToSave) {
    _calcsForReference.insert(0, calcToSave);
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
            onTap: () {
              int indexToDelete = _calcsForReference.indexOf(calcToSave);
              _savedCalcs.removeAt(indexToDelete);
              _calcsForReference.removeAt(indexToDelete);
              notifyParent();
            },
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

  Map<String, String> toMap() {
    return {'test': "jfds;lk"};
  }

  String getName() {
    return _name;
  }

  String getId() {
    return _id;
  }

  void deleteCalculation() {}
}
