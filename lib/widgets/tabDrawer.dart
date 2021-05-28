import 'package:flutter/material.dart';
import 'package:adminapp/models/category.dart';
import 'package:adminapp/utils/flutter_ui_utils.dart';
import 'package:adminapp/widgets/tabBox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabDrawer extends StatelessWidget {
  final List<Category> categories;
  TabDrawer(this.categories);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.all(FlutterUiDart(context: context).getPercentWidth(1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: FlutterUiDart(context: context).getPercentHeight(3),
                ),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: FlutterUiDart(context: context).getPercentWidth(10),
                ),
                Container(
                  height: FlutterUiDart(context: context).getPercentHeight(5),
                  child: Center(
                    child: Text(
                      "User",
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: categories.length,
                          separatorBuilder: (context, index) {
                            return Container(
                              color: Theme.of(context).accentColor,
                              height: FlutterUiDart(context: context)
                                  .getPercentHeight(0.5),
                            );
                          },
                          itemBuilder: (context, index) {
                            return TabBox(category: categories[index]);
                          },
                        ),
                        ListTile(
                          leading: IconButton(
                              splashColor: Theme.of(context).primaryColor,
                              splashRadius: 30,
                              icon: Icon(Icons.add),
                              onPressed: () {
                                print("jf");
                                Navigator.of(context).pushNamed(
                                    '/categoryAddPage',
                                    arguments: <String, bool>{
                                      "updatesc": false
                                    });
                              }),
                          trailing: IconButton(
                              splashColor: Theme.of(context).primaryColor,
                              onPressed: () {},
                              icon: Icon(Icons.remove)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          FloatingActionButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('adminlogged');
                Navigator.of(context).pushReplacementNamed('/loginPage');
              },
              foregroundColor: Colors.brown)
        ],
      ),
    );
  }
}
