import 'package:flutter/material.dart';
import 'package:sqfliteexample/helpers/DatabaseHelper.dart';
import 'package:sqfliteexample/screen/UpdateProduct.dart';
import 'package:sqfliteexample/screen/viewdata.dart';

class ViewScreen extends StatefulWidget {
  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {


  Future<List>? allproducts;

  Future<List> getdata(type) async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var data = await obj.getProducts(type);
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allproducts = getdata("all");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Product"),
          actions: [
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              // onSelected: (x)
              // {
              //  if(x==1)
              //    {
              //      Navigator.of(context).push(
              //        MaterialPageRoute(builder: (context) => Google_news())
              //      );
              //    }
              // },
              color: Colors.white,

              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("All"),
                  onTap: () {
                    setState(() {
                      allproducts = getdata("all");
                    });
                  },
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text("Similar Product"),
                  onTap: (){
                    setState(() {
                      allproducts = getdata("simple");
                    });
                  },
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text("Variable Product"),
                  onTap: (){
                    setState(() {
                      allproducts = getdata("variable");
                    });
                  },
                ),
              ],
            ),
          ]),
      body: SafeArea(
        child: FutureBuilder(
          future: allproducts,
          builder: (context,snapshot)
          {
            if(snapshot.hasData)
              {
                if(snapshot.data!.length == 0)
                  {
                    return Center(
                      child: Text("No Data"),
                    );
                  }
                else
                  {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context,index)
                      {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250.0,
                          margin: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          color: Colors.red.shade200,
                          child: Column(
                            children: [
                              Text(snapshot.data![index]["pid"].toString()),
                              Text(snapshot.data![index]["pname"].toString()),
                              Text(snapshot.data![index]["price"].toString()),
                              Text(snapshot.data![index]["types"].toString()),
                              Text(snapshot.data![index]["description"].toString()),
                              Text(snapshot.data![index]["category"].toString()),
                              ElevatedButton(onPressed: ()
                              {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => UpdateProduct(
                                    uid: snapshot.data![index]["pid"].toString(),
                                    productname: snapshot.data![index]["pname"].toString(),
                                  ))
                                );
                              },
                                  child: Text("Edit")),
                              ElevatedButton(onPressed: () async
                              {
                                AlertDialog alert = new AlertDialog(
                                  title: Text("Warning!"),
                                  content: Text("Are you sure you want to delete?"),
                                  actions: [
                                    ElevatedButton(onPressed: () async{
                                      Navigator.of(context).pop();
                                      var id = snapshot.data![index]["pid"].toString();
                                      DatabaseHelper obj = new DatabaseHelper();
                                      var status = await obj.deleteProduct(id);
                                      if(status==1)
                                      {
                                        print("Record Deleted");
                                        setState(() {
                                          allproducts = getdata("all");
                                        });
                                      }
                                      else
                                      {
                                        print("Record not Deleted");
                                      }
                                    }, child: Text("Yes")),
                                    ElevatedButton(onPressed: (){
                                      Navigator.of(context).pop();
                                    }, child: Text("No")),
                                  ],
                                );

                                showDialog(context: context, builder: (context){
                                  return alert;
                                });

                              },
                                  child: Text("Delete")),
                              ElevatedButton(onPressed: (){
                                var id = snapshot.data![index]["pid"].toString();


                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>viewdata(
                                  vid:id
                                )));


                              }, child:Text("View"))
                            ],
                          ),
                        );
                        // return ListTile(
                        //   title: Text(snapshot.data![index]["pname"].toString()),
                        //   subtitle:  Text("Rs."+snapshot.data![index]["price"].toString()),
                        // );
                      },
                    );
                  }
              }
            else
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          },
        ),
      ),
    );
  }
}
