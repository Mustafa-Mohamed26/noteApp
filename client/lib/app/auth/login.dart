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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Form(
                    key: formState,
                    child: Column(
                      children: [
                        Image.asset("images/logo.png", width: 200, height: 200),
                        CustomTextForm(
                          valid: (val) {
                            return validInput(val!, 5, 40);
                          },
                          myController: email,
                          hint: "email",
                        ),
                        CustomTextForm(
                          valid: (val) {
                            return validInput(val!, 3, 10);
                          },
                          myController: password,
                          hint: "password",
                        ),
                        MaterialButton(
                          color: Colors.purple,
                          textColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
                          onPressed: () async {
                            await login();
                          },
                          child: Text("Login"),
                        ),
                        Container(
                          height: 10,
                        ),
                        InkWell(
                          child: Text("Sign Up"),
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
