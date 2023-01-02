import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../LocalDB/databaseHelper.dart';
import '../Model/HeaderModel.dart';

class ListScreenController extends GetxController {
  RxBool isLoading = false.obs;
  // List<Mymodel> model = [];
  late listModel response;
  Database? db;
  String url = 'https://qaadmin.onzway.com/apis/get-orders-v3.json';

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    // db = await DatabaseHelper.instance.database;
    await postData();
  }

  updateData() {
    isLoading.value = false;
    update();
  }

  Future postData() async {
    try {
      final apiResponse = await http.post(
        Uri.parse('https://qaadmin.onzway.com/apis/get-orders-v3.json'),
        headers: {
          'content-type': 'application/json',
        },
        body: json.encode(
            {"restaurant_id": "1", "status": 4, "page": 1, "search": "abc"}),
      );
      print(apiResponse.statusCode.toString());
      var decodJson = json.decode(apiResponse.body);
      response = listModel.fromJson(decodJson);
    } catch (e) {
      print(e.toString());
    }
    // print(apiResponse.statusCode.toString());

    updateData();
  }

  insert(String oid, String seq, String type, String date) async {
    // get a reference to the database
    // because this is an expensive operation we use async and await

    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.OrderId: oid,
      DatabaseHelper.Sequence: seq,
      DatabaseHelper.Type: type,
      DatabaseHelper.Date: date
    };

    // do the insert and get the id of the inserted row
    int id = await db!.insert(DatabaseHelper.table, row);

    // show the results: print all rows in the db
    print(await db!.query(DatabaseHelper.table));
  }

  Future deleteAll() async {
    Database? db = await DatabaseHelper.instance.database;
  }
}
