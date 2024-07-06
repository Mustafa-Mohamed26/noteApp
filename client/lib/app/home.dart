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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () {
              sharedPref.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'fail') {
                      return const Center(
                        child: Text(
                          "the list is empty",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return CardNotes(
                            onDelete: () async {
                              var response = await _crud.postRequest(
                                  linkDeleteNotes, {
                                "id": snapshot.data['data'][i]['notes_id']
                                    .toString()
                              });
                              if (response['status'] == 'success') {
                                Navigator.of(context)
                                    .pushReplacementNamed("home");
                              }
                            },
                            ontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditNotes(
                                      notes: snapshot.data['data'][i])));
                            },
                            noteModel:
                                NoteModel.fromJson(snapshot.data['data'][i]),
                          );
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text("Loading..."),
                    );
                  }
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
