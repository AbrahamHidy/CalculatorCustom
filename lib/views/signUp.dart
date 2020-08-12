import 'package:calculator_custom/calcPage.dart';
import 'package:calculator_custom/helpers/FunctionProvider.dart';
import 'package:calculator_custom/services/authorizor.dart';
import 'package:calculator_custom/services/databaser.dart';
import 'package:calculator_custom/widgets/styles.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function pageSwitch;
  SignUp(this.pageSwitch);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  WidgetProider widgetProvider = new WidgetProider();
  final formKey = GlobalKey<FormState>();

  Authorizor authorizor = new Authorizor();
  Databaser databaser = new Databaser();

  TextEditingController usernameTextControl = new TextEditingController();
  TextEditingController emailTextControl = new TextEditingController();
  TextEditingController passwordTextControl = new TextEditingController();

  signUp() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": usernameTextControl.text.trim(),
        "email": emailTextControl.text.trim(),
      };
      FunctionProvider.saveUsersEmail(emailTextControl.text.trim());
      FunctionProvider.saveUsersName(usernameTextControl.text.trim());

      setState(() {
        isLoading = true;
      });
      authorizor
          .signUpEmailPass(
              emailTextControl.text.trim(), passwordTextControl.text.trim())
          .then((value) {
        databaser.uploadUserInfo(userInfoMap);
        FunctionProvider.saveLoggedIn(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CalcPage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Create Account",
                  style: TextStyle(
                    fontSize: 30,
                  )),
              Icon(
                Icons.format_list_numbered,
                size: 200,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty || val.length < 4
                            ? 'Please use a valid email, more than 4 characters.'
                            : null;
                      },
                      controller: emailTextControl,
                      decoration: widgetProvider.formInputdecoration('Email'),
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty || val.length < 4
                            ? 'Please use a valid password, more than 4 characters.'
                            : null;
                      },
                      controller: passwordTextControl,
                      decoration:
                          widgetProvider.formInputdecoration('Password'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Sign Up!',
                  style: widgetProvider.buttonTextStyle(),
                ),
              ),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
