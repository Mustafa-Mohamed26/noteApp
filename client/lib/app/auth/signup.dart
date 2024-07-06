// ignore_for_file: prefer_final_fields, unnecessary_import, use_build_context_synchronously, avoid_print

import 'package:client/components/crud.dart';
import 'package:client/components/customtextform.dart';
import 'package:client/components/valid.dart';
import 'package:client/constant/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Crud _crud = Crud();

  bool isLoading = false;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        print("SignUp Fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Form(
                    key: formState,
                    child: Column(
                      children: [
                        Image.asset("images/logo.png", width: 200, height: 200),
                        CustomTextForm(
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                          myController: username,
                          hint: "username",
                        ),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
                          onPressed: () async {
                            await signUp();
                          },
                          child: const Text("Sign Up"),
                        ),
                        Container(
                          height: 10,
                        ),
                        InkWell(
                          child: const Text("Login"),
                          onTap: () {
                            Navigator.of(context).pushNamed('login');
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
