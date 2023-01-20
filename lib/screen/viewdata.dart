import 'package:flutter/material.dart';
import 'package:sqfliteexample/helpers/DatabaseHelper.dart';

class viewdata extends StatefulWidget {


  var vid="";
  viewdata({required this.vid});

  @override
  State<viewdata> createState() => _viewdataState();
}

class _viewdataState extends State<viewdata> {



  var pname="";
  var price="";

  getdata() async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var data = await obj.getsingleproduct(widget.vid);
    setState(() {
      pname = data[0]["pname"].toString();
      price = data[0]["price"].toString();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Data"),
      ),
      body: Column(
        children: [
          Text(pname),
          Text(price),
        ],
      ),
    );
  }
}
