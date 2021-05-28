import 'package:adminapp/apis/categoryAddingApi.dart';
import 'package:flutter/material.dart';
import 'package:adminapp/models/category.dart';
import 'package:adminapp/providers/homePageTabChange.dart';
import 'package:adminapp/utils/flutter_ui_utils.dart';
import 'package:provider/provider.dart';

class TabBox extends StatefulWidget {
  final Category category;
  TabBox({@required this.category});

  @override
  _TabBoxState createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  var select = false;
  @override
  Widget build(BuildContext context) {
    var tabProvider = Provider.of<HomePageTabChange>(context, listen: false);

    return Card(
      shadowColor: Colors.black,
      elevation: 5,
      child: ListTile(
          autofocus: true,
          minLeadingWidth: 40,
          contentPadding: EdgeInsetsDirectional.only(
              start: FlutterUiDart(context: context).getPercentWidth(3)),
          // focusColor: Theme.of(context).accentColor,
          // selectedTileColor: Theme.of(context).accentColor,
          // hoverColor: Theme.of(context).accentColor,
          selectedTileColor: select
              ? Theme.of(context).primaryColor
              : Theme.of(context).accentColor,
          enabled: true,
          selected: widget.category.categoryId == tabProvider.whichTab,
          leading: select
              ? IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print("del");
                    deleteCategory(categoryid: tabProvider.whichTab)
                        .then((value) {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context, '/homePage');
                    });
                  },
                )
              : Icon(Icons.access_alarm),
          title: select
              ? Text(
                  widget.category.category,
                  style: TextStyle(color: Colors.red),
                )
              : Text(widget.category.category),
          onTap: () {
            if (!select) {
              print("d");
              tabProvider.updateTabBox(widget.category, true);
            } else {
              setState(() {
                select = false;
              });
            }
          },
          onLongPress: () {
            setState(() {
              select = true;
            });
          }),
    );

    // return Container(
    //   color: Colors.amber,
    //   height: FlutterUiDart(context: context).getPercentHeight(7),
    //   child: FractionallySizedBox(
    //     widthFactor: 1,
    //     heightFactor: 1,
    //     child: FractionallySizedBox(
    //         alignment: Alignment.bottomCenter,
    //         widthFactor: 0.5,
    //         heightFactor: 0.05,
    //         child: Container(
    //           color: Theme.of(context).accentColor,
    //         )),
    //   ),
    // );
  }
}
