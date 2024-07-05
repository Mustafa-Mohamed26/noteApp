import 'package:client/components/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();
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
                    myController: username,
                    hint: "username",
                  ),
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
                    onPressed: () {},
                    child: Text("Sign Up"),
                  ),
                  Container(height: 10,),
                  InkWell(
                    child: Text("Login"),
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
