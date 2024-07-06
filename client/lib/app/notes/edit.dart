// ignore_for_file: prefer_final_fields, unnecessary_new, unused_import

import 'package:client/components/crud.dart';
import 'package:client/components/customtextform.dart';
import 'package:client/components/valid.dart';
import 'package:client/constant/linkapi.dart';
import 'package:client/main.dart';
import 'package:flutter/material.dart';

class EditNotes extends StatefulWidget {
  final notes;
  const EditNotes({super.key, this.notes});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  Crud _crud = new Crud();

  bool isLoading = false;

  editNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkEditNotes, {
        "title": title.text,
        "content": content.text,
        "id": widget.notes['notes_id'].toString(),
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
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit notes"),
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
                        await editNotes();
                      },
                      child: const Text("Edit"),
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
