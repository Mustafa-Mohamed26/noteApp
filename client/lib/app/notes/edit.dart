// ignore_for_file: prefer_final_fields, unnecessary_new, unused_import, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_const_constructors, sized_box_for_whitespace

import 'dart:io';

import 'package:client/components/crud.dart';
import 'package:client/components/customtextform.dart';
import 'package:client/components/valid.dart';
import 'package:client/constant/linkapi.dart';
import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditNotes extends StatefulWidget {
  final notes;
  const EditNotes({super.key, this.notes});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  File? myFile;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  Crud _crud = new Crud();

  bool isLoading = false;

  editNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response;

      if (myFile == null) {
        response = await _crud.postRequest(
          linkEditNotes,
          {
            "title": title.text,
            "content": content.text,
            "id": widget.notes['notes_id'].toString(),
            "imageName": widget.notes['notes_image'].toString(),
          },
        );
      } else {
        response = await _crud.postRequestWithFile(
          linkEditNotes,
          {
            "title": title.text,
            "content": content.text,
            "id": widget.notes['notes_id'].toString(),
            "imageName": widget.notes['notes_image'].toString(),
          },
          myFile!,
        );
      }

      isLoading = false;
      setState(() {});
      if (response['status'] == 'success') {
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        // code here
      }
    }
  }

  @override

  /// This function is called when the widget is first created. It sets the initial
  /// values of the `title` and `content` TextEditingControllers based on the values
  /// passed in through the `widget.notes` argument. The `super.initState()` call
  /// ensures that the parent class's `initState()` method is also called.
  void initState() {
    // Set the initial value of the `title` TextEditingController to the value of
    // the 'notes_title' key in the `widget.notes` map.
    title.text = widget.notes['notes_title'];

    // Set the initial value of the `content` TextEditingController to the value of
    // the 'notes_content' key in the `widget.notes` map.
    content.text = widget.notes['notes_content'];

    // Call the parent class's `initState()` method to ensure that any necessary
    // setup is performed.
    super.initState();
  }

  @override
  // This function is called every time the widget needs to be rendered.
  // It returns a Scaffold widget which is a basic layout for a screen.
  // The Scaffold widget has an AppBar widget (a bar at the top of the screen)
  // and a body widget (the content of the screen).
  // The AppBar widget has a title and a background color.
  // The body widget is a Container widget with padding around its child.
  // The child of the Container is a Form widget.
  // The Form widget has a key and a ListView widget as its child.
  // The ListView widget has two CustomTextForm widgets and three MaterialButton widgets as its children.
  // The CustomTextForm widgets allow users to input text.
  // The MaterialButton widgets allow users to choose an image from the gallery or camera, edit the notes, or choose an image.
  // The code is written in Dart, which is a programming language developed by Google.
  // The code is organized into classes, functions, and variables.
  // The code follows the Flutter framework's widget tree structure.
  Widget build(BuildContext context) {
    // Return the Scaffold widget
    return Scaffold(
      // The AppBar widget displays the title of the screen
      appBar: AppBar(
        title: Text("Edit notes"),
        backgroundColor: Colors.purple,
      ),
      // The body widget displays the content of the screen
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    // The first CustomTextForm widget allows users to input the title of the note
                    CustomTextForm(
                      hint: "title",
                      myController: title,
                      valid: (val) {
                        return validInput(val!, 1, 40);
                      },
                    ),
                    // The second CustomTextForm widget allows users to input the content of the note
                    CustomTextForm(
                      hint: "content",
                      myController: content,
                      valid: (val) {
                        return validInput(val!, 10, 255);
                      },
                    ),
                    // The first MaterialButton widget allows users to choose an image from the gallery or camera
                    MaterialButton(
                      onPressed: () async {
                        // Show a modal bottom sheet with options to select an image from the gallery or camera
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
                                    // Pick an image from the gallery
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
                                    // Take a picture with the camera
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
                    // The third MaterialButton widget allows users to edit the notes
                    MaterialButton(
                      onPressed: () async {
                        await editNotes();
                      },
                      textColor: Colors.white,
                      color: Colors.purple,
                      child: const Text("Edit"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
