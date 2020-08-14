import 'package:calculator_custom/calcPage.dart';
import 'package:calculator_custom/helpers/FunctionProvider.dart';
import 'package:calculator_custom/services/authorizor.dart';
import 'package:calculator_custom/widgets/styles.dart';
import 'package:flutter/material.dart';

class SignOut extends StatefulWidget {
  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  Authorizor authorizor = new Authorizor();
  WidgetProider widgetProvider = new WidgetProider();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlue.withAlpha(1000),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Log out?",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => authorizor.signOut().then((value) {
                FunctionProvider.saveLoggedIn(false);

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => CalcPage()));
              }),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Icon(
                  Icons.exit_to_app,
                  size: 110,
                  color: Colors.red,
                ),
              ), /*Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Log out',
                  style: widgetProvider.buttonTextStyle(),
                ),
              ),*/
            ),
          ],
        ));
  }
}
