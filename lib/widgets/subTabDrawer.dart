import 'package:flutter/material.dart';
import 'package:adminapp/models/category.dart';
import 'package:adminapp/models/subcategory.dart';
import 'package:adminapp/utils/flutter_ui_utils.dart';
import 'package:adminapp/widgets/subTabBox.dart';
import 'package:adminapp/widgets/tabBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adminapp/providers/homePageSubTabChange.dart';
import 'package:provider/provider.dart';

class SubTabDrawer extends StatelessWidget {
  final List<Subcategory> subcategories;
  SubTabDrawer(this.subcategories);
  @override
  Widget build(BuildContext context) {
    print(subcategories.length);
    var subtabProvider = Provider.of<HomePageSubTabChange>(context);
    return Padding(
      padding:
          EdgeInsets.all(FlutterUiDart(context: context).getPercentWidth(1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: SingleChildScrollView(
              child: (subcategories.length != 0)
                  ? Container(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: subcategories.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            color: Theme.of(context).accentColor,
                            height: FlutterUiDart(context: context)
                                .getPercentHeight(0.5),
                          );
                        },
                        itemBuilder: (context, index) {
                          return SubTabBox(subcategory: subcategories[index]);
                        },
                      ),
                    )
                  : Container(),
            ),
          ),
          ListTile(
            leading: IconButton(
                splashColor: Theme.of(context).primaryColor,
                splashRadius: 30,
                icon: Icon(Icons.add),
                onPressed: () {
                  print("jf");
                  Navigator.of(context).pushNamed('/categoryAddPage',
                      arguments: <String, bool>{"updatesc": true});
                }),
          ),
        ],
      ),
    );
  }
}
