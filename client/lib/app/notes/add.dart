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
  // This function builds the UI for the Add Notes page.
  // It returns a Scaffold widget which is the main container for the app's content.
  // The Scaffold widget has an AppBar (the top bar of the app) and a body (the main content of the app).
  // The AppBar has a title and a background color.
  // The body of the Scaffold is a Container widget which has padding and a child which is a Form widget.
  // The Form widget has a key and a child which is a ListView widget.
  // The ListView widget has children which are different widgets such as CustomTextForm, MaterialButton, and Container.
  // The CustomTextForm widgets are used to take input from the user for the title and content of the note.
  // The MaterialButton widgets are used to select an image from the gallery or camera.
  // When the user selects an image, the image is stored in the myFile variable.
  // The last MaterialButton widget is used to add the note.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title of the AppBar.
        title: Text("Add notes"),
        // The background color of the AppBar.
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
                    // A CustomTextForm widget for the title of the note.
                    CustomTextForm(
                      hint: "title",
                      myController: title,
                      valid: (val) {
                        return validInput(val!, 1, 40);
                      },
                    ),
                    // A CustomTextForm widget for the content of the note.
                    CustomTextForm(
                      hint: "content",
                      myController: content,
                      valid: (val) {
                        return validInput(val!, 10, 255);
                      },
                    ),
                    // A MaterialButton widget to select an image from the gallery or camera.
                    MaterialButton(
                      onPressed: () async {
                        // Shows a modal bottom sheet with options to select an image from the gallery or camera.
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
                                  // When the user taps on the gallery option, the image is selected from the gallery.
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
                                  // When the user taps on the camera option, the image is selected from the camera.
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
                      // The text color and background color of the button.
                      textColor: Colors.white,
                      color: myFile == null ? Colors.purple : Colors.grey,
                      // The text of the button.
                      child: Text("Choose image"),
                    ),
                    Container(
                      height: 20,
                    ),
                    // A MaterialButton widget to add the note.
                    MaterialButton(
                      // When the user taps on the button, the addNotes function is called.
                      onPressed: () async {
                        await addNotes();
                      },
                      // The text color and background color of the button.
                      textColor: Colors.white,
                      color: Colors.purple,
                      // The text of the button.
                      child: Text("Add"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
