// ignore_for_file: prefer_final_fields, unnecessary_new, use_build_context_synchronously, unused_import

import 'package:client/app/notes/edit.dart';
import 'package:client/components/cardnote.dart';
import 'package:client/components/crud.dart';
import 'package:client/constant/linkapi.dart';
import 'package:client/main.dart';
import 'package:client/model/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Crud _crud = new Crud();

  getNotes() async {
    var response = await _crud
        .postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
    return response;
  }

  @override
  // This is the build method of the Home widget. It returns a Scaffold
  // widget which contains the app bar, floating action button, and body.
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with title and exit button
      appBar: AppBar(
        title: const Text("HOME"),
        backgroundColor: Colors.purple,
        actions: [
          // Icon button for exiting the app
          IconButton(
            onPressed: () {
              // Clear shared preferences and navigate to login screen
              sharedPref.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      // Floating action button for adding a new note
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the add notes screen
          Navigator.of(context).pushNamed("addnotes");
        },
        child: const Icon(Icons.add),
      ),
      // Body of the home screen
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // Future builder for getting the list of notes
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // Check if the data is available
                  if (snapshot.hasData) {
                    // Check if the list is empty
                    if (snapshot.data['status'] == 'fail') {
                      return const Center(
                        child: Text(
                          "the list is empty",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    // Build the list of notes
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return CardNotes(
                            // Delete note function
                            onDelete: () async {
                              // Send a request to delete the note
                              var response =
                                  await _crud.postRequest(linkDeleteNotes, {
                                "id": snapshot.data['data'][i]['notes_id']
                                    .toString(),
                                "imageName": snapshot.data['data'][i]
                                        ['notes_image']
                                    .toString()
                              });
                              // If the delete was successful, navigate back to the home screen
                              if (response['status'] == 'success') {
                                Navigator.of(context)
                                    .pushReplacementNamed("home");
                              }
                            },
                            // Tap function for editing the note
                            ontap: () {
                              // Navigate to the edit notes screen with the note data
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditNotes(
                                      notes: snapshot.data['data'][i])));
                            },
                            // Note model for the note
                            noteModel:
                                NoteModel.fromJson(snapshot.data['data'][i]),
                          );
                        });
                  }
                  // Check if the data is still loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text("Loading..."),
                    );
                  }
                  // If the data is not available, show a loading message
                  return const Center(
                    child: Text("Loading..."),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
