import 'package:adminapp/apis/imageStoringApi.dart';
import 'package:adminapp/apis/saveItemApi.dart';
import 'package:adminapp/models/item.dart';
import 'package:adminapp/widgets/borderSplash.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class ItemEditPage extends StatefulWidget {
  ItemEditPage({Key key}) : super(key: key);
  @override
  _ItemEditPageState createState() => _ItemEditPageState();
}

class _ItemEditPageState extends State<ItemEditPage> {
  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();

  int _keyboardVisibilitySubscriberId;

  bool _keyboardState;

  @override
  void initState() {
    super.initState();

    _keyboardState = _keyboardVisibility.isKeyboardVisible;

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          print("jjjjj" + visible.toString());
          _keyboardState = visible;
        });
      },
    );
  }

  @override
  void dispose() {
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }

  double _getPercent(double p, double quan) {
    return ((p / 100) * quan);
  }

  final TextEditingController nameController = new TextEditingController();

  final TextEditingController detailsController = new TextEditingController();
  File imageUploaded = null;
  String imagePath = " ";

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    print("df" + MediaQuery.of(context).viewInsets.bottom.toString());
    var bottomline = MediaQuery.of(context).viewInsets.bottom;
    print(bottomline);
    return Scaffold(
      body: BorderSplash(
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Colors.brown,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    elevation: 10,
                    splashColor: Theme.of(context).primaryColor,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: Colors.brown,
                    child: Icon(Icons.done, color: Colors.white),
                    elevation: 10,
                    splashColor: Theme.of(context).primaryColor,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    onPressed: () {
                      String imglink;
                      uploadImage(imagePath).then((value) {
                        imglink = value;
                        String name = nameController.value.text;
                        String description = detailsController.value.text;
                        if (arguments['store']) {
                          storeItem(
                                  name: name,
                                  imglink: imglink,
                                  details: description,
                                  category: arguments['category'],
                                  subcategory: arguments['subcategory'])
                              .then((value) {
                            print(value);
                            Navigator.of(context).pushNamed('/homePage');
                          });
                        } else {
                          updateItem(
                                  name: name,
                                  imglink: imglink,
                                  details: description,
                                  id: arguments['item'].itemId,
                                  category: arguments['category'],
                                  subcategory: arguments['subcategory'])
                              .then((value) {
                            print(value);
                            Navigator.of(context).pushNamed('/homePage');
                          });
                        }
                      });

                      //  if(imagePath != " "){
                      //   //  updatePath = imagePath;
                      //  }
                      //  else{
                      //   //  updatePath = arguments['item'].                     }
                    },
                  ),
                ],
              ),
            ),
            body: LayoutBuilder(builder: (context, constraints) {
              return Stack(children: [
                Positioned(
                  // floatingActionButton: FloatingActionButton(
                  //   backgroundColor: Theme.of(context).primaryColor,
                  //   child: update
                  //       ? Icon(Icons.backspace_rounded, color: Colors.black)
                  //       : Icon(Icons.update, color: Colors.black),
                  //   elevation: 10,
                  //   splashColor: Colors.brown,
                  //   materialTapTargetSize: MaterialTapTargetSize.padded,
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed('/itemEditPage',
                  //         arguments: <String, String>{'itemid': widget.item.itemId});
                  //   },
                  // ),
                  left: _getPercent(5, constraints.maxWidth),
                  bottom: (bottomline == 0)
                      ? _getPercent(19, constraints.maxHeight)
                      : bottomline,
                  // _getPercent(5, constraints.maxHeight),

                  child: Container(
                    height: _getPercent(62, constraints.maxHeight),
                    width: _getPercent(90, constraints.maxWidth),
                    child: Column(
                      children: [
                        Container(
                          width: _getPercent(90, constraints.maxWidth),
                          height: _getPercent(5, constraints.maxHeight),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(0),
                                top: Radius.circular(20)),
                            color: Colors.brown,
                            boxShadow: [
                              BoxShadow(color: Colors.brown, spreadRadius: 3),
                            ],
                          ),
                          child: Center(
                            child: new ListTile(
                              onTap: () {
                                setState(() {
                                  _keyboardState =
                                      _keyboardVisibility.isKeyboardVisible;
                                });
                              },
                              contentPadding: EdgeInsets.all(0),
                              title: new TextField(
                                textAlign: TextAlign.center,
                                controller: nameController,
                                cursorColor: Theme.of(context).primaryColor,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    textBaseline: TextBaseline.ideographic),
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Name",
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    )),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(color: Colors.brown, spreadRadius: 3),
                            ],
                          ),
                          // color: Theme.of(context).primaryColor,
                          height: _getPercent(40, constraints.maxHeight),
                          width: _getPercent(90, constraints.maxWidth),
                          child: (imageUploaded != null)
                              ? Scaffold(
                                  backgroundColor: Colors.grey,
                                  floatingActionButton: FloatingActionButton(
                                    mini: true,
                                    heroTag: "btn3",
                                    backgroundColor: Colors.brown,
                                    child:
                                        Icon(Icons.cancel, color: Colors.white),
                                    elevation: 10,
                                    splashColor: Theme.of(context).primaryColor,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    onPressed: () {
                                      setState(() {
                                        imageUploaded = null;
                                        imagePath = " ";
                                      });
                                    },
                                  ),
                                  body: Center(
                                    child: Image.file(imageUploaded),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _takePicture(true).then((value) {
                                          print(value);
                                          setState(() {
                                            imageUploaded = value['file'];
                                            imagePath = value['path'];
                                          });
                                        });
                                      },
                                      child: Center(
                                          child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.brown,
                                        size: _getPercent(
                                            12, constraints.maxHeight),
                                      )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _takePicture(false).then((value) {
                                          print(value);
                                          setState(() {
                                            imageUploaded = value['file'];
                                            imagePath = value['path'];
                                          });
                                        });
                                      },
                                      child: Center(
                                          child: Icon(
                                        Icons.file_upload,
                                        color: Colors.brown,
                                        size: _getPercent(
                                            12, constraints.maxHeight),
                                      )),
                                    ),
                                  ],
                                ),
                        ),
// ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20),
                                  top: Radius.circular(0)),
                              color: Theme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(color: Colors.brown, spreadRadius: 3),
                              ],
                            ),
                            height: _getPercent(17, constraints.maxHeight),
                            width: _getPercent(90, constraints.maxWidth),
                            child: Form(
                              child: Container(
                                height: _getPercent(20, constraints.maxHeight),
                                width: _getPercent(100, constraints.maxWidth),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.details,
                                    color: Colors.black,
                                  ),
                                  title: TextField(
                                    expands: true,
                                    maxLines: null,
                                    minLines: null,
                                    controller: detailsController,
                                    cursorColor: Colors.black,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        textBaseline: TextBaseline.ideographic),
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Details",
                                        hintStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        )),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ]);
            }),
          ),
          effect: false),
    );
  }

  File _storedImage;
  Future<Map<String, dynamic>> _takePicture(bool cam) async {
    final imageFile = await ImagePicker.pickImage(
      source: cam ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return {"file": null, "path": " "};
    }
    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    print('${appDir.path}/$fileName');
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    return {"file": savedImage, "path": '${appDir.path}/$fileName'};
  }
}
