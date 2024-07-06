// ignore_for_file: unnecessary_new, prefer_final_fields, use_build_context_synchronously

import 'package:client/components/crud.dart';
import 'package:client/components/customtextform.dart';
import 'package:client/components/valid.dart';
import 'package:client/constant/linkapi.dart';
import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  Crud _crud = new Crud();

  bool isLoading = false;

  addNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkAddNotes, {
        "title": title.text,
        "content": content.text,
        "id": sharedPref.getString("id")
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == 'success') {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        // code here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add notes"),
        backgroundColor: Colors.purple,
      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustomTextForm(
                      hint: "title",
                      myController: title,
                      valid: (val) {
                        return validInput(val!, 1, 40);
                      },
                    ),
                    CustomTextForm(
                      hint: "content",
                      myController: content,
                      valid: (val) {
                        return validInput(val!, 10, 255);
                      },
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await addNotes();
                      },
                      child: Text("Add"),
                      textColor: Colors.white,
                      color: Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
