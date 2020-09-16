import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator_custom/helpers/functionProvider.dart';
import 'package:calculator_custom/helpers/numberFormatter.dart';
import 'package:calculator_custom/models/calcLogger.dart';
import 'package:calculator_custom/models/calculation.dart';
import 'package:calculator_custom/services/databaser.dart';
import 'package:calculator_custom/views/accountScreen.dart';
import 'package:calculator_custom/widgets/buttonTile.dart';
import 'package:calculator_custom/widgets/drawerItem.dart';
import 'package:calculator_custom/widgets/styles.dart';
import 'package:flutter/cupertino.dart';
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
  TextEditingController nameTextController = new TextEditingController();
  WidgetProider widgetProider = new WidgetProider();

  Databaser databaser = new Databaser();
  CalcLogger logger;
  Stream calcLoggerStream;
  String usersEmail = '';

  String displayText = '';
  String userInput = '';
  bool calculated = false;
  WidgetProider widgetProvider = new WidgetProider();

  refresh() {
    setState(() {});
  }

  Widget button(String lable) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      onTap: () {
        if (lable == 'Save') {
          if (calculated) {
            logger.saveCalculation(Calculation(displayText, userInput));
            calculated = false;
          }
        } else if (lable == "Clear") {
          displayText = '';
          userInput = '';
          calculated = false;
        } else if (lable == '=') {
          expression = parser
              .parse(displayText.replaceAll('(', "*(").replaceAll(')', ')'));
          userInput = displayText;
          double result =
              expression.evaluate(EvaluationType.REAL, contextModel);
          displayText = NumberFormatter.format(result);
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
            displayText = '';
            calculated = false;
          }
          displayText += lable;
        } else {
          displayText += lable;
          calculated = false;
        }
        setState(() {});
      },
      child: ButtonTile(lable),
    );
  }

  void getUserEmail() async {
    await PreferenceSaver.getUsersEmail().then((value) {
      if (value != null) {
        usersEmail = value;
      } else {
        usersEmail = null;
      }
    });

    setState(() {});
  }

  @override
  void initState() {
    logger = new CalcLogger(notifyParent: refresh);
    getUserEmail();
    getCalcLoggerStream();
    super.initState();
  }

  void getCalcLoggerStream() async {
    calcLoggerStream = databaser
        .getSavedCalcSessionsStream(await PreferenceSaver.getUsersEmail());
    setState(() {});
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
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          logger = new CalcLogger(notifyParent: refresh);
                          logger
                              .setID(snapshot.data.documents[index].documentID);
                          logger.fromMap(snapshot.data.documents[index].data);
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              snapshot.data.documents[index].data['name']
                                  .toString(),
                              style: TextStyle(
                                fontSize: 25,
                              ),
                              //textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Column(
                                        children: [
                                          Text("Delete calc session?"),
                                          InkResponse(
                                            onTap: () {
                                              databaser.deleteCalculation(
                                                  snapshot.data.documents[index]
                                                      .documentID);
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.delete_forever),
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            : CircularProgressIndicator();
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
          child: Column(children: [
            DrawerHeader(
              child: usersEmail == null || usersEmail == ""
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountScreen()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Log in!',
                          style: widgetProvider.buttonTextStyle(),
                        ),
                      ),
                    )
                  : Text(usersEmail),
            ),
            Expanded(
              child: calcSessionList(),
            ),
          ]),
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
          title: OutlineButton(
            onPressed: logger.getName() == null
                ? () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Column(
                              children: [
                                TextField(
                                  maxLength: 13,
                                  controller: nameTextController,
                                  decoration: widgetProider
                                      .formInputdecoration('Session name'),
                                ),
                                InkResponse(
                                  onTap: () {
                                    if (nameTextController.text != '') {
                                      logger.setName(
                                          nameTextController.text.trim());
                                    }
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.check,
                                      size: 30,
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                : () {
                    final action = CupertinoActionSheet(
                      title: logger.getName() == null
                          ? Text(
                              'Unnamed Session',
                              style: TextStyle(fontSize: 30),
                            )
                          : Text(
                              logger.getName(),
                              style: TextStyle(fontSize: 30),
                            ),
                      message: Text(
                        "Select any action ",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: Text("Upload to cloud"),
                          isDefaultAction: true,
                          onPressed: () {
                            databaser.uploadCalculation(logger);
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: Text("Clear session"),
                          isDestructiveAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              logger = new CalcLogger(notifyParent: refresh);
                            });
                          },
                        )
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                    showCupertinoModalPopup(
                        context: context, builder: (context) => action);
                  },
            child: Text(logger.getName() == null
                ? 'Unnamed Session'
                : logger.getName()),
          ),
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
                displayText,
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
