import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> validate(
    {@required String username, @required String password}) async {
  var valid;
  // var reload;
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
  final pref = await SharedPreferences.getInstance();
  await http
      .post(
    'https://safe-springs-56633.herokuapp.com/api/admin/validate',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  )
      .then((response) {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['validity']);
      valid = jsonResponse['validity'];
      pref.setString('adminlogged', username);
    } else {
      print('false');
      valid = false;
    }
  }).catchError((error) {
    print("error occured");
    valid = false;
  });
  print("h");
  return valid;
}
