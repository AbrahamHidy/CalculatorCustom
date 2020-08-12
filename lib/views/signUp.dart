import 'package:calculator_custom/services/authorizor.dart';
import 'package:calculator_custom/services/databaser.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function pageSwitch;
  SignUp(this.pageSwitch);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  Authorizor authorizor = new Authorizor();
  Databaser databaser = new Databaser();

  TextEditingController usernameTextControl = new TextEditingController();
  TextEditingController emailTextControl = new TextEditingController();
  TextEditingController passwordTextControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
