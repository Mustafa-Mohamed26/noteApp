import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function()? ontap;
  final String title;
  final String content;
  const CardNotes({super.key, required this.ontap, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Image.asset(
                  "images/logo.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("$title"),
                  subtitle: Text("$content"),
                ))
          ],
        ),
      ),
    );
  }
}
