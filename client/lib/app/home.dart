import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        backgroundColor: Colors.purple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            InkWell(
              onTap: (){},
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
                          title: Text("title Note"),
                          subtitle: Text("content note"),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
