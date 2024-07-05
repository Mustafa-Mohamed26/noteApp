import 'package:client/components/customtextform.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  Image.asset("images/logo.png", width: 200, height: 200),
                  CustomTextForm(
                    myController: email,
                    hint: "email",
                  ),
                  CustomTextForm(
                    myController: password,
                    hint: "password",
                  ),
                  MaterialButton(
                    color: Colors.purple,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                    onPressed: () {
                      Navigator.of(context).pushNamed("home");
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
