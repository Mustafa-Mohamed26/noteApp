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
  // The build method is called when the widget is rendered.
  // It returns a Scaffold widget, which is a pre-designed
  // widget that provides a basic layout structure.
  Widget build(BuildContext context) {
    // The Scaffold widget is wrapped in a Container with padding.
    // This is to add some space around the edges of the screen.
    return Scaffold(
      body: isLoading == true
          ? // If isLoading is true, show a CircularProgressIndicator.
            const Center(child: CircularProgressIndicator())
          : // If isLoading is false, show the following widgets.
            Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  // The children of the ListView are arranged vertically.
                  // The first child is a Form widget.
                  Form(
                    key: formState,
                    child: Column(
                      children: [
                        // The first child of the Column is an Image widget.
                        // It displays the logo of the app.
                        Image.asset("images/logo.png", width: 200, height: 200),
                        // The second child is a CustomTextForm widget.
                        // It is a custom widget that allows users to input text.
                        // It has a validator function that checks if the input is valid.
                        // The validator function is passed as a parameter to the widget.
                        // The myController parameter is a TextEditingController.
                        // The hint parameter is a string that is displayed as a hint.
                        CustomTextForm(
                          valid: (val) {
                            // The validator function checks if the input is valid.
                            // It returns a boolean value indicating whether the input is valid.
                            // The validInput function is a helper function that checks if the input is valid.
                            // It takes three parameters: the input value, the minimum length, and the maximum length.
                            // If the input value is within the specified length range, it returns true.
                            // Otherwise, it returns false.
                            return validInput(val!, 3, 20);
                          },
                          myController: username,
                          hint: "username",
                        ),
                        // The third child is another CustomTextForm widget.
                        // It has the same properties as the second child.
                        // The only difference is the minimum length and maximum length of the input.
                        CustomTextForm(
                          valid: (val) {
                            return validInput(val!, 5, 40);
                          },
                          myController: email,
                          hint: "email",
                        ),
                        // The fourth child is another CustomTextForm widget.
                        // It has the same properties as the second child.
                        // The only difference is the minimum length and maximum length of the input.
                        CustomTextForm(
                          valid: (val) {
                            return validInput(val!, 3, 10);
                          },
                          myController: password,
                          hint: "password",
                        ),
                        // The fifth child is a MaterialButton widget.
                        // It has a color and text color.
                        // The padding parameter specifies the space between the child and the button's edges.
                        // The onPressed parameter is a callback function that is called when the button is pressed.
                        // The callback function calls the signUp function.
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
                        // The sixth child is a Container widget with a height of 10.
                        // It adds some space between the button and the text below.
                        Container(
                          height: 10,
                        ),
                        // The seventh child is an InkWell widget.
                        // It is used to create a clickable area.
                        // The child parameter is a Text widget that displays the text "Login".
                        // The onTap parameter is a callback function that is called when the text is tapped.
                        // The callback function navigates to the 'login' route.
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
