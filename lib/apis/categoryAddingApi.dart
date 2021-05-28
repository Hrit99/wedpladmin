import 'dart:convert';
import 'package:adminapp/models/category.dart';
import 'package:adminapp/models/item.dart';
import 'package:adminapp/models/subcategory.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> storeCategory(
    {@required Category category,
    @required List<Subcategory> subcategories}) async {
  var stored;
  // await http
  //     .post('https://safe-springs-56633.herokuapp.com/api/userid/reloadcheck',
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8'
  //         },
  //         body: jsonEncode(<String, String>{"userId": username}))
  //     .then((value) {
  //   reload = jsonDecode(value.body)['reload'];
  // }).catchError((_) => print("some error occured"));

  // pref.setBool("reload", reload);
  List<Map<String, String>> scnames = new List<Map<String, String>>();
  for (var subcategory in subcategories) {
    scnames.add({"subcategory": subcategory.subcategory});
  }
  print(scnames.toString());

  await http
      .post(
    'https://safe-springs-56633.herokuapp.com/api/category/storeCategory',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'category': category.category,
      'subcategories': scnames,
    }),
  )
      .then((response) {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['stored']);
      stored = jsonResponse['stored'];
    } else {
      print('false');
      stored = false;
    }
  }).catchError((error) {
    print("error occured");
    stored = false;
  });
  print(stored);
  return Future.value(stored);
}

Future<bool> deleteCategory({@required String categoryid}) async {
  var deleted;
  // await http
  //     .post('https://safe-springs-56633.herokuapp.com/api/userid/reloadcheck',
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8'
  //         },
  //         body: jsonEncode(<String, String>{"userId": username}))
  //     .then((value) {
  //   reload = jsonDecode(value.body)['reload'];
  // }).catchError((_) => print("some error occured"));

  // pref.setBool("reload", reload);
  // List<Map<String, String>> scnames = new List<Map<String, String>>();
  // for (var subcategory in subcategories) {
  //   scnames.add({"subcategory": subcategory.subcategory});
  // }
  // print(scnames.toString());

  await http
      .post(
    'https://safe-springs-56633.herokuapp.com/api/category/deleteCategory',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      '_id': categoryid,
    }),
  )
      .then((response) {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['deleted']);
      deleted = jsonResponse['deleted'];
    } else {
      print('false');
      deleted = false;
    }
  }).catchError((error) {
    print("error occured");
    deleted = false;
  });
  print(deleted);
  return Future.value(deleted);
}

Future<bool> validateCategory({@required String category}) async {
  var valid;
  // await http
  //     .post('https://safe-springs-56633.herokuapp.com/api/userid/reloadcheck',
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8'
  //         },
  //         body: jsonEncode(<String, String>{"userId": username}))
  //     .then((value) {
  //   reload = jsonDecode(value.body)['reload'];
  // }).catchError((_) => print("some error occured"));

  // pref.setBool("reload", reload);
  // List<Map<String, String>> scnames = new List<Map<String, String>>();
  // for (var subcategory in subcategories) {
  //   scnames.add({"subcategory": subcategory.subcategory});
  // }
  // print(scnames.toString());

  await http
      .post(
    'https://safe-springs-56633.herokuapp.com/api/category/validateCategory',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'category': category,
    }),
  )
      .then((response) {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['validity']);
      valid = jsonResponse['validity'];
    } else {
      print('false');
      valid = false;
    }
  }).catchError((error) {
    print("error occured");
    valid = false;
  });
  print(valid);
  return Future.value(valid);
}

Future<bool> updateCategory(
    {@required Category category,
    @required List<Subcategory> subcategories}) async {
  var updated;
  // await http
  //     .post('https://safe-springs-56633.herokuapp.com/api/userid/reloadcheck',
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8'
  //         },
  //         body: jsonEncode(<String, String>{"userId": username}))
  //     .then((value) {
  //   reload = jsonDecode(value.body)['reload'];
  // }).catchError((_) => print("some error occured"));

  // pref.setBool("reload", reload);
  List<Map<String, String>> scnames = new List<Map<String, String>>();
  for (var subcategory in subcategories) {
    scnames.add({"subcategory": subcategory.subcategory});
  }
  print(scnames.toString());

  await http
      .post(
    'https://safe-springs-56633.herokuapp.com/api/category/updateCategory',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      '_id': category.categoryId,
      'category': category.category,
      'subcategories': scnames
    }),
  )
      .then((response) {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['updated']);
      updated = jsonResponse['updated'];
    } else {
      print('false');
      updated = false;
    }
  }).catchError((error) {
    print("error occured");
    updated = false;
  });
  print(updated);
  return Future.value(updated);
}
