import 'package:flutter/material.dart';
import 'package:sqfliteexample/screen/Add_product.dart';
import 'package:sqfliteexample/screen/ViewScreen.dart';

class Sqflite_Example extends StatefulWidget {
  @override
  State<Sqflite_Example> createState() => _Sqflite_ExampleState();
}

class _Sqflite_ExampleState extends State<Sqflite_Example> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqflite"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Welcome, Guest!"),
              accountEmail: Text("test@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Text("A"),
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Home",),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>Add_product())
                );
              },
            ),
            ListTile(
              title: Text("View",),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ViewScreen())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
