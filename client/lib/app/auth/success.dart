// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  // This is the build method for the Success widget. It is called by Flutter
  // whenever it needs to rebuild the widget.
  //
  // The build method returns a Scaffold widget which is a basic layout widget
  // that provides a visual structure for the app.
  //
  // Inside the Scaffold, we have a Column widget which stacks its children
  // vertically. The mainAxisAlignment property is set to center which centers
  // the children both horizontally and vertically.
  //
  // The first child is a Center widget which centers its child both horizontally
  // and vertically. The child is a Text widget which displays the message
  // "Account Created Successfully". The Text widget is styled with a font size
  // of 20.
  //
  // The second child is a MaterialButton widget. When the button is pressed, the
  // onPressed callback is called. The onPressed callback navigates to the login
  // screen by calling Navigator.of(context).pushNamedAndRemoveUntil(). The
  // pushNamedAndRemoveUntil() method pushes the named route to the top of the
  // Navigator stack and removes all the previous routes. The callback provided
  // to removeUntil() is a function that returns true for all routes, effectively
  // removing all previous routes.
  //
  // The MaterialButton is styled with a text color of white and a color of
  // purple. The child of the MaterialButton is a Text widget which displays the
  // text "Login".
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center the text widget both horizontally and vertically
          Center(
            child: Text(
              "Account Created Successfully",
              style: TextStyle(fontSize: 20),
            ),
          ),
          // Create a MaterialButton with a text "Login" and a callback to navigate
          // to the login screen.
          MaterialButton(
            onPressed: () {
              // Navigate to the login screen by pushing the named route and removing
              // all previous routes.
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            textColor: Colors.white,
            color: Colors.purple,
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}
