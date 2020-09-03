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

  void setID(String id) {
    _id = id;
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
        "result": _calcsForReference[i].getResult(),
        "expression": _calcsForReference[i].getExpression(),
        "timeCreated": _calcsForReference[i].timeCreated,
      };
      calcArr.add(calculationMap);
    }
    toRet.addAll({"calculations": calcArr});
    return toRet;
  }

  void fromMap(Map<String, dynamic> loggerMap) {
    _name = loggerMap["name"];
    _id = loggerMap["id"];
    timeCreated = new DateTime.fromMillisecondsSinceEpoch(
        loggerMap["timeCreated"].millisecondsSinceEpoch);
    for (int i = 0; i < loggerMap["calculations"].length; i++) {
      Calculation calc = new Calculation(loggerMap["calculations"][i]["result"],
          loggerMap["calculations"][i]["expression"]);
      //calc.setCreationTime(loggerMap["calculations"][i]["timeCreated"]);  Need to convert the timestamp to a datetime.
      saveCalculation(calc);
    }
  }

  String getName() {
    return _name;
  }

  String getId() {
    return _id;
  }
}
