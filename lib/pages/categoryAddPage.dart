import 'dart:ui';

import 'package:adminapp/models/category.dart';
import 'package:adminapp/models/item.dart';
import 'package:adminapp/models/subcategory.dart';
import 'package:adminapp/providers/homePageTabChange.dart';
import 'package:flutter/material.dart';
import 'package:adminapp/apis/categoryAddingApi.dart';
import 'package:provider/provider.dart';

class CategoryAdd extends StatelessWidget {
  double _sigmaX = 0.5; // from 0-10
  double _sigmaY = 0.0; // from 0-10
  double _opacity = 0.4;
  @override
  Widget build(BuildContext context) {
    var tabProvider = Provider.of<HomePageTabChange>(context, listen: false);
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    var update = arguments['updatesc'];
    TextEditingController cname = new TextEditingController();
    return Scaffold(
        body: Container(
      color: Theme.of(context).accentColor,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
        child: Container(
          color: Colors.white.withOpacity(_opacity),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  selectedTileColor: Colors.white,
                  title: TextField(
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    controller: cname,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.done,
                    color: Colors.brown,
                  ),
                  onPressed: () {
                    if (update) {
                      Category c = tabProvider.whichCategory;
                      List<Item> items = new List<Item>();
                      c.subcategories.add(Subcategory(
                          subcategoryId: " ",
                          subcategory: cname.value.text,
                          items: items));
                      updateCategory(
                              category: c, subcategories: c.subcategories)
                          .then((value) {
                        Navigator.pop(context);
                        Navigator.popAndPushNamed(context, '/homePage');
                      });
                    } else {
                      Category c = Category(
                          categoryId: " ",
                          category: cname.value.text,
                          subcategories: []);
                      List<Subcategory> sclist = new List<Subcategory>();
                      print('d');
                      validateCategory(category: c.category).then((value) {
                        print(value);
                        if (!value) {
                          storeCategory(category: c, subcategories: sclist)
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context, '/homePage');
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
