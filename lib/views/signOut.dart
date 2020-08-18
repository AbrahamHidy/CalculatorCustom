import 'package:calculator_custom/helpers/FunctionProvider.dart';
import 'package:calculator_custom/services/authorizor.dart';
import 'package:calculator_custom/views/calcPage.dart';
import 'package:calculator_custom/widgets/styles.dart';
import 'package:flutter/material.dart';

class SignOut extends StatefulWidget {
  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  String usersEmail;
  Authorizor authorizor = new Authorizor();
  WidgetProider widgetProvider = new WidgetProider();
  @override
  void initState() {
    getUserEmail();
    super.initState();
  }

  void getUserEmail() async {
    usersEmail = await FunctionProvider.getUsersEmail();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
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
            Text(
              usersEmail,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 60,
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
