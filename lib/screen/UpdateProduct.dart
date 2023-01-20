import 'package:flutter/material.dart';
import 'package:sqfliteexample/helpers/DatabaseHelper.dart';
import 'package:sqfliteexample/screen/ViewScreen.dart';

class UpdateProduct extends StatefulWidget {


  var uid="";
  var productname="";

  UpdateProduct({required this.uid,required this.productname});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  TextEditingController _product=TextEditingController();
  TextEditingController _price=TextEditingController();
  TextEditingController _description=TextEditingController();

  var _value="variable";
  var _selected ="clothing";

  var pn="";

  getsingledata() async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var singleproduct = await obj.getsingleproduct(widget.uid);
    setState(() {
      // pn = singleproduct[0]["pname"].toString();
      _product.text = singleproduct[0]["pname"].toString();
      _price.text = singleproduct[0]["price"].toString();
      _description.text = singleproduct[0]["description"].toString();
      _value =  singleproduct[0]["types"].toString();
      _selected =  singleproduct[0]["category"].toString();
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsingledata();
    //_product.text = widget.productname.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pn),
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


                                DatabaseHelper obj = new DatabaseHelper();
                                var st = await obj.updateProduct(name,price,type,description,category,widget.uid);
                                if(st==1)
                                  {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context)=>ViewScreen())
                                    );
                                  }
                                else
                                  {
                                    print("Not Updated");
                                  }

                              }, child: Padding(
                                padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                                child: Text("Update",style: TextStyle(
                                    fontSize: 20.0
                                ),),
                              )),
                            ),
                            // Text(pn),
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
