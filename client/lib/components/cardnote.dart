import 'package:client/constant/linkapi.dart';
import 'package:client/model/notemodel.dart';
import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function()? ontap;
  final NoteModel noteModel;
  final void Function()? onDelete;
  const CardNotes(
      {super.key,
      required this.ontap,
      required this.onDelete,
      required this.noteModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoute/${noteModel.notesImage}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${noteModel.notesTitle}"),
                  subtitle: Text("${noteModel.notesContent}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
