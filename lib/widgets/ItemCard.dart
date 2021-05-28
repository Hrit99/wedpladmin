import 'package:adminapp/providers/homePageTabChange.dart';
import 'package:flutter/material.dart';
import 'package:adminapp/models/item.dart';
import 'package:adminapp/providers/homePageSubTabChange.dart';
import 'package:adminapp/utils/flutter_ui_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:adminapp/apis/saveItemApi.dart';

class ItemCard extends StatefulWidget {
  var constraints;
  Item item;
  int index;
  ItemCard(this.constraints, this.item, this.index);
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  var height;
  var extended = false;

  double _getPercent(double p, double quan) {
    return ((p / 100) * quan);
  }

  bool update = false;
  var del = false;
  @override
  Widget build(BuildContext context) {
    var subtabProvider =
        Provider.of<HomePageSubTabChange>(context, listen: false);
    var tabProvider = Provider.of<HomePageTabChange>(context, listen: false);
    var itemid = widget.item.itemId;
    return Container(
      height: extended
          ? _getPercent(70, widget.constraints.maxHeight)
          : _getPercent(50, widget.constraints.maxHeight),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "btn${widget.index}",
          backgroundColor: Theme.of(context).primaryColor,
          child: update
              ? Icon(Icons.backspace_rounded, color: Colors.black)
              : Icon(Icons.update, color: Colors.black),
          elevation: 10,
          splashColor: Colors.brown,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          onPressed: () {
            Navigator.of(context)
                .pushNamed('/itemEditPage', arguments: <String, dynamic>{
              'store': false,
              'item': widget.item,
              'subcategory': subtabProvider.whichSubcategory.subcategory,
              'category': tabProvider.whichCategory.category
            });
          },
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                height: _getPercent(5, widget.constraints.maxHeight),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(0), top: Radius.circular(20)),
                  color: Colors.brown,
                  // boxShadow: [
                  //   // BoxShadow(color: Colors.brown, spreadRadius: 3),
                  // ],
                  border: Border.all(
                    color: Colors.brown,
                    width: _getPercent(1, widget.constraints.maxWidth),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.item.name,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.ideographic),
                  ),
                ),
              ),

              GestureDetector(
                onLongPress: () {
                  setState(() {
                    del = true;
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    extended = !extended;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(
                      color: Colors.brown,
                      width: _getPercent(1, widget.constraints.maxWidth),
                    ),
                    color: Theme.of(context).primaryColor,
                    // boxShadow: [
                    //   BoxShadow(color: Colors.brown, spreadRadius: 3),
                    // ],
                  ),
                  // color: Theme.of(context).primaryColor,
                  height: _getPercent(45, widget.constraints.maxHeight),
                  width: _getPercent(96, widget.constraints.maxWidth),
                  child: del
                      ? Container(
                          color: Colors.white,
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.delete,
                                  color: Colors.red, size: 50),
                              onPressed: () {
                                deleteItem(
                                        category:
                                            tabProvider.whichCategory.category,
                                        subcategory: subtabProvider
                                            .whichSubcategory.subcategory,
                                        itemid: widget.item.itemId)
                                    .then((value) {
                                  Navigator.pop(context);
                                  Navigator.popAndPushNamed(
                                      context, '/homePage');
                                });
                              },
                            ),
                          ),
                        )
                      : FittedBox(
                          fit: BoxFit.fill,
                          child: Center(
                            child: Image.network(widget.item.mediaUrl),
                          ),
                        ),
                ),
              ),
// ),
              extended
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                            top: Radius.circular(0)),
                        border: Border.all(
                          color: Colors.brown,
                          width: _getPercent(1, widget.constraints.maxWidth),
                        ),
                        color: Theme.of(context).primaryColor,
                        // boxShadow: [
                        //   BoxShadow(color: Colors.brown, spreadRadius: 3),
                        // ],
                      ),
                      height: _getPercent(20, widget.constraints.maxHeight),
                      child: Center(
                          child: Text(
                        widget.item.details,
                        style: TextStyle(color: Colors.black),
                      )),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

// Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.vertical(
//                     bottom: Radius.circular(0), top: Radius.circular(20)),
//                 color: Colors.brown,
//                 boxShadow: [
//                   BoxShadow(color: Colors.brown, spreadRadius: 3),
//                 ],
//               ),
//               width: _getPercent(100, widget.constraints.maxWidth),
//               height: _getPercent(5, widget.constraints.maxHeight),
//               child: Center(
//     child: Text(
//   widget.item.name,
//   style: TextStyle(
//       color: Theme.of(context).primaryColor,
//       fontWeight: FontWeight.bold,
//       textBaseline: TextBaseline.ideographic),
// )),
//             ),
// GestureDetector(
// onDoubleTap: () {
//   setState(() {
//     extended = !extended;
//   });
// },
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(0),
//         color: Colors.grey,
//         boxShadow: [
//           BoxShadow(color: Colors.brown, spreadRadius: 3),
//         ],
//       ),
//       height: _getPercent(45, widget.constraints.maxHeight),
//       width: _getPercent(100, widget.constraints.maxWidth),
//       child: FittedBox(
//           fit: BoxFit.fill,
//           child: Image.network(widget.item.mediaUrl)),
//     )),
//             extended
//                 ? Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.vertical(
//                           bottom: Radius.circular(20), top: Radius.circular(0)),
//                       color: Theme.of(context).primaryColor,
//                       boxShadow: [
//                         BoxShadow(color: Colors.brown, spreadRadius: 3),
//                       ],
//                     ),
//                     height: _getPercent(20, widget.constraints.maxHeight),
//                     width: _getPercent(100, widget.constraints.maxWidth),
//                     child: Center(
//                         child: Text(
//                       widget.item.details,
//                       style: TextStyle(color: Colors.black),
//                     )),
//                   )
//                 : Container()
//           ],
//         ),

// new ListTile(
//   leading: const Icon(Icons.details),
//   title: new TextField(
//     expands: true,
//     maxLines: null,
//     minLines: null,
//     controller: nameController,
//     decoration: new InputDecoration(
//       hintText: "Details",
//     ),
//   ),
// ),

//  Container(
//                       color: Colors.brown,
//                       width: _getPercent(100, widget.constraints.maxWidth),
//                       height: _getPercent(5, widget.constraints.maxHeight),
//                       child: Center(
//                         child: new ListTile(
//                           contentPadding: EdgeInsets.all(0),
//                           title: new TextField(
//                             textAlign: TextAlign.center,
//                             controller: nameController,
//                             cursorColor: Theme.of(context).primaryColor,
//                             style: TextStyle(
//                                 color: Theme.of(context).primaryColor,
//                                 fontWeight: FontWeight.bold,
//                                 textBaseline: TextBaseline.ideographic),
//                             decoration: new InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Name",
//                                 hintStyle: TextStyle(
//                                   color: Theme.of(context).primaryColor,
//                                 )),
//                           ),
//                         ),
//                       ),
//                     )
//                   :

// Container(
//                           color: Theme.of(context).primaryColor,
//                           height: _getPercent(45, widget.constraints.maxHeight),
//                           width: _getPercent(100, widget.constraints.maxWidth),
//                           child: GestureDetector(
//                             onTap: () {
//                               print("add photo");
//                             },
//                             child: Center(
//                                 child: Icon(
//                               Icons.file_upload,
//                               color: Colors.brown,
//                               size:
//                                   _getPercent(20, widget.constraints.maxHeight),
//                             )),
//                           ),
//                         )

// Container(
//                       height: _getPercent(20, widget.constraints.maxHeight),
//                       width: _getPercent(100, widget.constraints.maxWidth),
//                       color: Theme.of(context).primaryColor,
//                       child: update
//                           ? Form(
//                               child: Container(
//                                 color: Colors.blue,
//                                 height: _getPercent(
//                                     20, widget.constraints.maxHeight),
//                                 width: _getPercent(
//                                     100, widget.constraints.maxWidth),
//                                 child: ListTile(
//                                   leading: const Icon(Icons.details),
//                                   title: TextField(
//                                     expands: true,
//                                     maxLines: null,
//                                     minLines: null,
//                                     controller: detailsController,
//                                     cursorColor: Theme.of(context).primaryColor,
//                                     style: TextStyle(
//                                         color: Theme.of(context).primaryColor,
//                                         fontWeight: FontWeight.bold,
//                                         textBaseline: TextBaseline.ideographic),
//                                     decoration: new InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText: "Details",
//                                         hintStyle: TextStyle(
//                                           color: Theme.of(context).primaryColor,
//                                         )),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           :
