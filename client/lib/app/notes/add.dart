// ignore_for_file: unnecessary_new, prefer_final_fields, use_build_context_synchronously, prefer_const_constructors, unnecessary_import, avoid_unnecessary_containers

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:client/components/crud.dart';
import 'package:client/components/customtextform.dart';
import 'package:client/components/valid.dart';
import 'package:client/constant/linkapi.dart';
import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  File? myFile;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  Crud _crud = new Crud();

  bool isLoading = false;

  addNotes() async {
    if (myFile == null) {
      return AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title: "Error",
              desc: "Please select an image")
          .show();
    }
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequestWithFile(
        linkAddNotes,
        {
          "title": title.text,
          "content": content.text,
          "id": sharedPref.getString("id")
        },
        myFile!,
      );
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
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Please choose Image",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    XFile? xFile = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    Navigator.of(context).pop();
                                    myFile = File(xFile!.path);
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "From Gallery",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    XFile? xFile = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    Navigator.of(context).pop();
                                    myFile = File(xFile!.path);
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "From Camera",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      textColor: Colors.white,
                      color: myFile == null ? Colors.purple : Colors.grey,
                      child: Text("Choose image"),
                    ),
                    Container(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await addNotes();
                      },
                      textColor: Colors.white,
                      color: Colors.purple,
                      child: Text("Add"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
