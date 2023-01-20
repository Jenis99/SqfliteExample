import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../helpers/DatabaseHelper.dart';

class Add_product extends StatefulWidget {
  @override
  State<Add_product> createState() => _Add_productState();
}

class _Add_productState extends State<Add_product> {
  TextEditingController _product=TextEditingController();
  TextEditingController _price=TextEditingController();
  TextEditingController _description=TextEditingController();
  var _value="variable";
  var _selected ="clothing";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
          child: (
              Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 10.0,right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.0,),
                            Text("Product Name",style: TextStyle(
                                fontSize: 20.0
                            ),),
                            SizedBox(height: 5.0,),
                            TextField(
                              decoration: InputDecoration (
                                focusedBorder: OutlineInputBorder(
                                  borderSide:BorderSide(color: Colors.blue ),
                                ),
                                enabledBorder:  OutlineInputBorder(
                                  borderSide:BorderSide(color: Colors.black),
                                ),
                              ),
                              controller: _product,
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: 10.0,),
                            Text("Price",style: TextStyle(
                                fontSize: 20.0
                            ),),
                            SizedBox(height: 5.0,),
                            TextField(
                              decoration: InputDecoration (
                                focusedBorder: OutlineInputBorder(
                                  borderSide:BorderSide(color: Colors.blue ),
                                ),
                                enabledBorder:  OutlineInputBorder(
                                  borderSide:BorderSide(color: Colors.black),
                                ),
                              ),
                              controller: _price,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 10.0,),
                            Text("Types",style: TextStyle(
                                fontSize: 20.0
                            ),),
                            Row(
                              children: [
                                Radio(
                                  value: "simple", groupValue: _value, onChanged: (value){
                                  setState(() {
                                    _value=value!;
                                  });
                                },),
                                Text("simple") ,
                                Radio(
                                  value: "variable", groupValue: _value, onChanged: (value){
                                  setState(() {
                                    _value=value!;
                                  });
                                },),
                                Text("variable"),
                              ],
                            ),
                            Text("Discription",style: TextStyle(
                                fontSize: 20.0
                            ),),
                            SizedBox(height: 5.0,),
                            TextField(
                              decoration: InputDecoration (
                                focusedBorder: OutlineInputBorder(
                                  borderSide:BorderSide(color: Colors.blue ),
                                ),
                                enabledBorder:  OutlineInputBorder(
                                  borderSide:BorderSide(color: Colors.black),
                                ),
                              ),
                              controller: _description,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                            SizedBox(height: 5.0,),
                            Text("Categories",style: TextStyle(
                                fontSize: 20.0
                            ),),
                            SizedBox(height: 3.0,),
                            Container(child: DropdownButton(
                              value: _selected,
                              onChanged: (val) {
                                setState(() {
                                  _selected = val!;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                  child: Text("clothing",style: TextStyle(
                                    fontSize: 13.0,
                                  ),),
                                  value: "clothing",),
                                DropdownMenuItem(
                                  child: Text("Footwear"),
                                  value: "Footwear",),
                                DropdownMenuItem(
                                  child: Text("Furnitures"),
                                  value: "Furnitures",),
                              ],
                            ),
                            ),
                            Center(
                              child:  ElevatedButton(onPressed: () async{
                                var name=_product.text.toString();
                                var price=_price.text.toString();
                                var type=_value.toString();
                                var description=_description.text.toString();
                                var category=_selected.toString();

                                //Database


                                if(name != "" || price!="" || type!="" || description!="" || category!=""){
                                  {
                                    DatabaseHelper obj = new DatabaseHelper();
                                    var id = await obj.insert_product(name,price,type,description,category);
                                    print("Record inserted At : "+id.toString());
                                    //Database

                                    _product.text="";
                                    _price.text="";
                                    _value="";
                                    _description.text="";
                                    _selected="";
                                    final snackBar = SnackBar(
                                      /// need to set following properties for best effect of awesome_snackbar_content
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'On Snap!',
                                        message:
                                        'This is an example error message that will be shown in the body of snackbar!',

                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.success,
                                      ),
                                    );

                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                  };
                                }
                                  else{
                                    final snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Error!',
                                    message:
                                    'This is an example error message that will be shown in the body of snackbar!',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.failure,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);

                                }


                              }, child: Padding(
                                padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                                child: Text("Add",style: TextStyle(
                                    fontSize: 20.0
                                ),),
                              )),
                            )
                          ],
                        )
                    ),
                  ]
              )
          )
      ),
    );
  }
}
