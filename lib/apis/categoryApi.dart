import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:adminapp/apis/itemsApi.dart';
import 'package:adminapp/apis/reloadCheckApi.dart';
import 'package:adminapp/models/item.dart';
import '../models/category.dart';
import '../models/subcategory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';

Future<List<Category>> getAllCategories() async {
  print("enter dc");
  List<Category> allCategories = List<Category>();
  var resp;
  print("ddd1");

  // var username = prefs.getString('adminusername') ?? null;
  // await reloadCheck(username: username);
  // print("reloadc ends");

  // FileCache fileCache = await FileCache.fromDefault();
  // var data = await fileCache
  //     .getJson('https://safe-springs-56633.herokuapp.com/api/category');
  // print(jsonDecode(data['response']));
  // String cacheRes = prefs.getString('categoryRes') ?? null;
  // print("l;");
  // print(cacheRes);
  // print(prefs.getBool("reload"));
  // if (prefs.getBool("reload")) {
  //   cacheRes = null;
  // }
  // if (cacheRes == null) {
  var reload;
  final pref = await SharedPreferences.getInstance();
  String adminname = pref.getString('adminlogged');
  print(adminname);
  await http
      .post('https://safe-springs-56633.herokuapp.com/api/adminid/reloadcheck',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, String>{"adminId": adminname}))
      .then((value) {
    reload = jsonDecode(value.body)['reload'];
    print("dddd3");
    print(reload);
  }).catchError((_) => print("some error occured"));
  print('gff');

  // print("hfhfh");
  // for (var c in categorydata) {
  //   print(c.category);
  //   for (var sc in c.subcategories) {
  //     print(sc.subcategory);
  //     for (var i in sc.items) {
  //       print(i.name);
  //     }
  //   }
  // }
  if (reload == false) {
    resp = pref.getString('admincategoryresp');
  } else {
    print("g;");
    await http
        .get('https://safe-springs-56633.herokuapp.com/api/category')
        .then((response) {
      if (response.statusCode == 200) {
        print(response.body.toString());
        resp = response.body.toString();
      } else {
        resp = null;
        print("kdk");
      }
    }).catchError((err) {
      print(err);
      resp = null;
    });
    pref.setString('admincategoryresp', resp);
  }

  print("k;");
  print(resp);
  var response = jsonDecode(resp);
  List categories = response['response'];

  for (var category in categories) {
    List subcategories;
    await _getListSubcategories(category, reload).then((value) {
      subcategories = value;
    });
    Category oneCategory = Category(
        categoryId: category['_id'],
        category: category['category'],
        subcategories: subcategories);
    allCategories.add(oneCategory);
  }
  for (var cat in allCategories) {
    print(cat.category);
  }
  print("going to return ${allCategories[0].category}");
  print("seer");
  return Future.value(allCategories);
}

Future<List<Subcategory>> _getListSubcategories(
    var category, bool reload) async {
  List<Subcategory> subcategories = List<Subcategory>();
  List<Item> items;
  for (var subcategory in category['subcategories']) {
    await getAllItems(category['category'], subcategory['subcategory'], reload)
        .then((value) {
      items = value;
    });
    subcategories.add(Subcategory(
        subcategoryId: subcategory['_id'],
        subcategory: subcategory['subcategory'],
        items: items));
  }
  return subcategories;
}
