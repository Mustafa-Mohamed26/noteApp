// ignore_for_file: prefer_final_fields, unnecessary_import, use_build_context_synchronously, avoid_print, unnecessary_new, prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:client/components/crud.dart';
import 'package:client/components/customtextform.dart';
import 'package:client/components/valid.dart';
import 'package:client/constant/linkapi.dart';
import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud _crud = new Crud();

  bool isLoading = false;

  login() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkLogin, {
        "email": email.text,
        "password": password.text,
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        sharedPref.setString("id", response['data']['id'].toString());
        sharedPref.setString("username", response['data']['username']);
        sharedPref.setString("email", response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
          context: context,
          title: "warning",
          body: const Text(
            "email or password not exist",
            style: TextStyle(fontSize: 20),
          ),
        ).show();
      }
    }
  }

  @override
  // This is the build method of the Login widget. It returns a Scaffold widget
  // which is a pre-designed app bar and bottom navigation bar. The body of the
  // Scaffold is a ListView widget which contains a Form widget. The Form widget
  // contains an Image widget, two CustomTextForm widgets, a MaterialButton widget,
  // a Container widget, and an InkWell widget.
  Widget build(BuildContext context) {
    return Scaffold(
      // The body of the Scaffold is a Container widget which has padding around
      // its child widgets.
      body: Container(
        padding: const EdgeInsets.all(10),
        // The child of the Container is either a CircularProgressIndicator widget
        // or a ListView widget.
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                // The ListView has one child, a Form widget.
                children: [
                  Form(
                    // The Form widget has a key which is used to identify it.
                    key: formState,
                    child: Column(
                      // The Column widget has multiple children widgets.
                      children: [
                        // The first child is an Image widget.
                        Image.asset("images/logo.png", width: 200, height: 200),
                        // The second child is a CustomTextForm widget.
                        CustomTextForm(
                          // The CustomTextForm widget has a validator function
                          // which is used to validate the input.
                          valid: (val) {
                            return validInput(val!, 5, 40);
                          },
                          // The CustomTextForm widget has two controllers, one
                          // for the text input and one for the input decoration.
                          myController: email,
                          hint: "email",
                        ),
                        // The third child is another CustomTextForm widget.
                        CustomTextForm(
                          valid: (val) {
                            return validInput(val!, 3, 10);
                          },
                          myController: password,
                          hint: "password",
                        ),
                        // The fourth child is a MaterialButton widget.
                        MaterialButton(
                          // The MaterialButton widget has a color and text color.
                          color: Colors.purple,
                          textColor: Colors.white,
                          // The MaterialButton widget has padding around its child.
                          padding: EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
                          // The MaterialButton widget has an onPressed function
                          // which is called when the button is pressed.
                          onPressed: () async {
                            await login();
                          },
                          // The MaterialButton widget has a child Text widget.
                          child: Text("Login"),
                        ),
                        // The fifth child is a Container widget.
                        Container(
                          height: 10,
                        ),
                        // The sixth child is an InkWell widget.
                        InkWell(
                          // The InkWell widget has a child Text widget.
                          child: Text("Sign Up"),
                          // The InkWell widget has an onTap function which is
                          // called when the widget is tapped.
                          onTap: () {
                            Navigator.of(context).pushNamed('signup');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
