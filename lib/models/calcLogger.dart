import 'package:calculator_custom/models/calculation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CalcLogger {
  List<Widget> _savedCalcTiles = [];
  List<Calculation> _calcsForReference = [];
  String _name;
  String _id;
  DateTime timeCreated = DateTime.now();
  final Function notifyParent;

  CalcLogger({Key key, @required this.notifyParent});

  void saveCalculation(Calculation calcToSave) {
    _calcsForReference.insert(0, calcToSave);
    _savedCalcTiles.insert(
      0,
      Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.grey.withAlpha(300),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              child: Text((_savedCalcTiles.length + 1).toString()),
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
              _savedCalcTiles.removeAt(indexToDelete);
              _calcsForReference.removeAt(indexToDelete);
              notifyParent();
            },
          ),
        ],
      ),
    );
  }

  void setName(String name) {
    _name = name;
  }

  int getLength() {
    return _savedCalcTiles.length;
  }

  List<Widget> getLoggedCalcs() {
    return _savedCalcTiles;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> toRet = {
      "name": _name,
      "id": _id,
      "timeCreated": timeCreated,
    };
    List<Map<String, dynamic>> calcArr = [];
    for (int i = 0; i < _calcsForReference.length; i++) {
      Map<String, dynamic> calculationMap = {
        "result $i": _calcsForReference[i].getResult(),
        "expression $i": _calcsForReference[i].getExpression(),
        "timeCreated $i": _calcsForReference[i].timeCreated,
      };
      calcArr.add(calculationMap);
    }
    toRet.addAll({"calculations": calcArr});
    return toRet;
  }

  String getName() {
    return _name;
  }

  String getId() {
    return _id;
  }

  void deleteCalculation() {}
}
