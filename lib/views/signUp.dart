import 'package:calculator_custom/helpers/functionProvider.dart';
import 'package:calculator_custom/services/authorizor.dart';
import 'package:calculator_custom/services/databaser.dart';
import 'package:calculator_custom/views/calcPage.dart';
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
  bool error = false;
  String errorMessage = '\nPlease ensure the requirements are met.';

  WidgetProider widgetProvider = new WidgetProider();
  final formKey = GlobalKey<FormState>();

  Authorizor authorizor = new Authorizor();
  Databaser databaser = new Databaser();

  TextEditingController emailTextControl = new TextEditingController();
  TextEditingController passwordTextControl = new TextEditingController();

  signUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      /*Map<String, String> userInfoMap = {
        "email": emailTextControl.text.trim(),
      };*/

      authorizor
          .signUpEmailPass(
              emailTextControl.text.trim(), passwordTextControl.text.trim())
          .then((value) {
        if (value != null) {
          databaser.uploadUserInfo(emailTextControl.text.trim());
          PreferenceSaver.saveLoggedIn(true);
          PreferenceSaver.saveUsersEmail(emailTextControl.text.trim());

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CalcPage()));
        } else {
          setState(() {
            error = true;
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Create Account${!error ? "" : errorMessage}",
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
                            decoration:
                                widgetProvider.formInputdecoration('Email'),
                          ),
                          TextFormField(
                            obscureText: true,
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
                    GestureDetector(
                      onTap: () => signUp(),
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
                          'Sign Up!',
                          style: widgetProvider.buttonTextStyle(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Already have an account?   '),
                          GestureDetector(
                            onTap: widget.pageSwitch,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.blue,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
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
