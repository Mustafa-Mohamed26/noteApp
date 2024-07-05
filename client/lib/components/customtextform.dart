import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String? hint;
  final TextEditingController myController;
  const CustomTextForm({super.key, required this.hint, required this.myController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: myController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          hintText: hint,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}