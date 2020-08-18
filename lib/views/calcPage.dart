import 'package:calculator_custom/models/calcSession.dart';
import 'package:calculator_custom/views/accountScreen.dart';
import 'package:calculator_custom/widgets/buttonTile.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcPage extends StatefulWidget {
  @override
  _CalcPageState createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> {
  final parser = Parser();
  Expression expression;
  ContextModel contextModel = new ContextModel();

  String calculation = '';
  bool calculated = false;
  List<Widget> children = [];
  ListView list = new ListView();

  CalcSession currentCalcSession = new CalcSession(
    'name',
    DateTime.now(),
    DateTime.now(),
  );

  void saveCalculation() {
    print("TEST");
    children.add(
      ListTile(
        title: Center(
          child: Text(
            calculation,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
    print(calculation);
    print(children);
  }

  Widget buttonTile(String lable) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      onTap: () {
        if (lable == 'Save') {
          saveCalculation();
        } else if (lable == "Clear") {
          calculation = '';
          calculated = false;
        } else if (lable == '=') {
          expression = parser
              .parse(calculation.replaceAll('(', "*(").replaceAll(')', ')'));
          calculation =
              expression.evaluate(EvaluationType.REAL, contextModel).toString();
          calculated = true;
        } else if (lable == '1' ||
            lable == '2' ||
            lable == '3' ||
            lable == '4' ||
            lable == '5' ||
            lable == '6' ||
            lable == '7' ||
            lable == '8' ||
            lable == '9' ||
            lable == '0' ||
            lable == '.') {
          if (calculated) {
            calculation = '';
            calculated = false;
          }
          calculation += lable;
        } else {
          calculation += lable;
          calculated = false;
        }
        setState(() {});
      },
      child: ButtonTile(lable),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        //backgroundColor: Color(0xff555555),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  "Saved Calculations",
                  style: TextStyle(fontSize: 30, color: Colors.blue),
                ),
                focusColor: Colors.blue,
              ),
              ListTile(
                title: Text(
                  "Test 1",
                  style: TextStyle(fontSize: 20),
                ),
                focusColor: Colors.blue,
              ),
              ListTile(
                title: Text(
                  "Test 2",
                  style: TextStyle(fontSize: 20),
                ),
                hoverColor: Colors.blue,
              ),
              ListTile(
                title: Text(
                  "Test 3",
                  style: TextStyle(fontSize: 20),
                ),
                focusColor: Colors.blue,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountScreen()));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.person)),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Cloud Calc',
            style:
                TextStyle(color: Colors.black, fontSize: 28, letterSpacing: 3),
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 130,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: children.length,
                  itemBuilder: (BuildContext context, int index) {
                    return children[index];
                  },
                ),
              ),
              Container(
                child: Text(
                  calculation,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                //alignment: Alignment.bottomCenter,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  children: [
                    buttonTile('+'),
                    buttonTile('-'),
                    buttonTile('*'),
                    buttonTile('/'),
                    buttonTile('1'),
                    buttonTile('2'),
                    buttonTile('3'),
                    buttonTile('Save'),
                    buttonTile('4'),
                    buttonTile('5'),
                    buttonTile('6'),
                    buttonTile('Clear'),
                    buttonTile('7'),
                    buttonTile('8'),
                    buttonTile('9'),
                    buttonTile('='),
                    buttonTile('0'),
                    buttonTile('.'),
                    buttonTile('('),
                    buttonTile(')'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
