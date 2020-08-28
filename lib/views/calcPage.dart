import 'package:calculator_custom/models/calcLogger.dart';
import 'package:calculator_custom/models/calcSession.dart';
import 'package:calculator_custom/models/calculation.dart';
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

  CalcLogger logger;

  String calculation = '';
  String userInput = '';
  bool calculated = false;

  refresh() {
    setState(() {});
  }

  CalcSession currentCalcSession = new CalcSession(
    'name',
    DateTime.now(),
    DateTime.now(),
  );

  Widget button(String lable) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      onTap: () {
        if (lable == 'Save') {
          logger.saveCalculation(Calculation(calculation, userInput));
        } else if (lable == "Clear") {
          calculation = '';
          userInput = '';
          calculated = false;
        } else if (lable == '=') {
          expression = parser
              .parse(calculation.replaceAll('(', "*(").replaceAll(')', ')'));
          userInput = calculation;
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
  void initState() {
    logger = new CalcLogger(notifyParent: refresh);
    super.initState();
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
          style: TextStyle(color: Colors.black, fontSize: 28, letterSpacing: 3),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              color: Colors.amber,
              height: 130,
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: logger.getLength(),
                itemBuilder: (BuildContext context, int index) {
                  return logger.getLoggedCalcs()[index];
                },
              ),
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
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                color: Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                //alignment: Alignment.bottomCenter,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  children: [
                    button('+'),
                    button('-'),
                    button('*'),
                    button('/'),
                    button('7'),
                    button('8'),
                    button('9'),
                    button('Save'),
                    button('4'),
                    button('5'),
                    button('6'),
                    button('Clear'),
                    button('1'),
                    button('2'),
                    button('3'),
                    button('='),
                    button('0'),
                    button('.'),
                    button('('),
                    button(')'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
