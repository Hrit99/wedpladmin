import 'dart:convert';
import 'package:adminapp/models/item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> updateItem(
    {@required String name,
    @required String imglink,
    @required String details,
    @required String id,
    @required String category,
    @required String subcategory}) async {
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
  await http
      .post(
    'https://safe-springs-56633.herokuapp.com/api/item/updateItem',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'category': category,
      'subcategory': subcategory,
      '_id': id,
      'name': name,
      'link': imglink,
      'details': details,
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
  print("h");
  return Future.value(updated);
}

Future<bool> storeItem(
    {@required String name,
    @required String imglink,
    @required String details,
    @required String category,
    @required String subcategory}) async {
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
  await http
      .post(
    'https://safe-springs-56633.herokuapp.com/api/item/storeItem',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'category': category,
      'subcategory': subcategory,
      'name': name,
      'link': imglink,
      'details': details,
    }),
  )
      .then((response) {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['stored']);
      updated = jsonResponse['stored'];
    } else {
      print('false');
      updated = false;
    }
  }).catchError((error) {
    print("error occured");
    updated = false;
  });
  print("h");
  return Future.value(updated);
}

Future<bool> deleteItem(
    {@required String category,
    @required String subcategory,
    @required String itemid}) async {
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
  await http
      .post(
    'https://safe-springs-56633.herokuapp.com/api/item/deleteItem',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'category': category,
      'subcategory': subcategory,
      '_id': itemid,
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
  print("h");
  return Future.value(deleted);
}
