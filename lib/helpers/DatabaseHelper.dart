import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper
{

   Database? db;


  //Database Create method
  Future<Database> create_db() async
  {
    if(db!=null)
      {
        print("Already DB created");
        return db!;
      }
    else
      {
        print("New DB created");
        Directory dir = await getApplicationDocumentsDirectory();
        String path = join(dir.path,"shopping_db");
        var db = await openDatabase(path,version: 1,onCreate: create_table);
        return db!;
      }
  }

  create_table(Database db,int version) async
  {
    // Table create
    db.execute("create table product (pid integer primary key autoincrement,pname text,"
        "price double,types text,description text,category text)");
    print("Table Created");
  }


  //Member function
  Future<int> insert_product(name,price,type,description,category) async
  {
    //Db create/table create
    var db = await create_db();
    //insert
    var id = await db.rawInsert("insert into product (pname,price,types,description,category) values (?,?,?,?,?)",[name,price,type,description,category]);
    return id;
  }
  Future<List> getProducts(type) async
  {
    //Db create/table create
    var db = await create_db();
    var query = "";
    if (type == "all")
      {
        query = "select * from product";
      }
    else if(type=="simple")
      {
        query = "select * from product where types='simple'";
      }
    else
      {
        query = "select * from product where types='variable'";
      }
    var data = await db.rawQuery(query);
    return data.toList();
  }
   Future<List> getSimpleProducts() async
   {
     //Db create/table create
     var db = await create_db();
     var data = await db.rawQuery("select * from product where types='simple'");
     return data.toList();
   }
  Future<int> deleteProduct(id) async
  {
    //Db create/table create
    var db = await create_db();
    var status = await db.rawDelete("delete from product where pid=?",[id]);
    return status;
  }
   Future<List> getsingleproduct(id) async
   {
     //Db create/table create
     var db = await create_db();
     var data = await db.rawQuery("select * from product where pid=?",[id]);
     return data.toList();
   }

   Future<int> updateProduct(name,price,type,description,category,id) async
   {
     //Db create/table create
     var db = await create_db();
     var status = await db.rawUpdate("update product set pname=?,price=?,types=?,description=?,category=? where pid=?",[name,price,type,description,category,id]);
     return status;
   }
}