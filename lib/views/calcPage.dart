import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator_custom/helpers/functionProvider.dart';
import 'package:calculator_custom/helpers/numberFormatter.dart';
import 'package:calculator_custom/models/calcLogger.dart';
import 'package:calculator_custom/models/calculation.dart';
import 'package:calculator_custom/services/databaser.dart';
import 'package:calculator_custom/views/accountScreen.dart';
import 'package:calculator_custom/widgets/buttonTile.dart';
import 'package:calculator_custom/widgets/drawerItem.dart';
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

  Databaser databaser = new Databaser();
  CalcLogger logger;
  Stream calcLoggerStream;

  String calculation = '';
  String userInput = '';
  bool calculated = false;

  refresh() {
    setState(() {});
  }

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
          double result =
              expression.evaluate(EvaluationType.REAL, contextModel);
          calculation = NumberFormatter.format(result);
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
    getCalcLoggerStream();
    super.initState();
  }

  void getCalcLoggerStream() async {
    calcLoggerStream =
        databaser.getSavedCalcSessions(await PreferenceSaver.getUsersEmail());
  }

  Widget calcSessionList() {
    return StreamBuilder(
      stream: calcLoggerStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Text(
                    snapshot.data.documents[index].data['timeCreated']
                        .toString(),
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              )
            : Container(child: Text("Failed"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white, //Color(0xff555555),
        drawer: Drawer(
          child: calcSessionList(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.grey.withAlpha(400),
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.person,
                      color: Colors.blue,
                    )),
              ),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: DropdownButton(items: [
            DropdownMenuItem(
              child: GestureDetector(
                  onTap: () => databaser.uploadCalculation(logger),
                  child: Text('Upload')),
            )
          ], onChanged: null),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              //height: 45,
              child: AutoSizeText(
                calculation,
                maxLines: 1,
                //maxFontSize: 40,
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
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
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
      ),
    );
  }
}
