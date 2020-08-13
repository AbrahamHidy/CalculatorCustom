import 'package:calculator_custom/helpers/FunctionProvider.dart';
import 'package:calculator_custom/views/signIn.dart';
import 'package:calculator_custom/views/signUp.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isLoggedIn = false;
  bool hasAccount = true;

  void pageSwitch() {
    setState(() {
      hasAccount = !hasAccount;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void getLoggedIn() async {
    await FunctionProvider.getLoggedIn().then((value) {
      setState(() {
        if (value != null) {
          isLoggedIn = value;
        } else {
          isLoggedIn = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ? null
          : hasAccount ? SignIn(pageSwitch) : SignUp(pageSwitch),
    );
  }
}
