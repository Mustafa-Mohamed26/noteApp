// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String? hint;
  final String? Function(String?)? valid;
  final TextEditingController myController;
  const CustomTextForm({super.key, required this.hint, required this.myController, required this.valid});

  @override
  // This is the build method for the CustomTextForm widget. It returns a Container
  // with a TextFormField inside. The TextFormField is a text input field that allows the
  // user to enter text. The validator is set to the valid function, which is used to
  // validate the text entered by the user. The controller is set to the myController
  // which is used to get the text entered by the user. The decoration is set to an
  // InputDecoration which is used to customize the appearance of the text field.
  // The contentPadding is set to a EdgeInsets with vertical and horizontal padding of
  // 8 and 10 respectively. The hintText is set to the hint string. The border is set
  // to an OutlineInputBorder with a black color and width of 1. The borderRadius is set
  // to a Radius.circular with a radius of 10.
  Widget build(BuildContext context) {
    return Container(
      // The margin is set to an EdgeInsets with a bottom padding of 10.
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        // The validator is set to the valid function.
        validator: valid,
        // The controller is set to the myController.
        controller: myController,
        // The decoration is set to an InputDecoration.
        decoration: InputDecoration(
          // The contentPadding is set to an EdgeInsets with vertical and horizontal padding of
          // 8 and 10 respectively.
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          // The hintText is set to the hint string.
          hintText: hint,
          // The border is set to an OutlineInputBorder with a black color and width of 1.
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
            // The borderRadius is set to a Radius.circular with a radius of 10.
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
