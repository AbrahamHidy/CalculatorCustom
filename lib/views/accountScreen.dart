import 'package:calculator_custom/helpers/functionProvider.dart';
import 'package:calculator_custom/views/signIn.dart';
import 'package:calculator_custom/views/signOut.dart';
import 'package:calculator_custom/views/signUp.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isLoggedIn = false;
  bool hasAccount = true;
  bool isLoading = true;

  void pageSwitch() {
    setState(() {
      hasAccount = !hasAccount;
    });
  }

  @override
  void initState() {
    super.initState();
    getLoggedIn();
    isLoading = false;
  }

  void getLoggedIn() async {
    await PreferenceSaver.getLoggedIn().then((value) {
      setState(() {
        if (value != null) {
          isLoggedIn = value;
        } else {
          isLoggedIn = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: false,
              title: Text(
                'Account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            body: isLoggedIn
                ? SignOut()
                : hasAccount ? SignIn(pageSwitch) : SignUp(pageSwitch),
          );
  }
}
