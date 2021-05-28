import 'package:adminapp/models/item.dart';
import 'package:flutter/material.dart';
import 'package:adminapp/models/subcategory.dart';

class HomePageSubTabChange with ChangeNotifier {
  var _currentSubTabId = "";
  Subcategory _currentSubTab;

  String get whichSubTab {
    print(_currentSubTabId);
    return _currentSubTabId;
  }

  Subcategory get whichSubcategory {
    return _currentSubTab;
  }

  void updateSubTabBox(Subcategory subcategory, bool notify) {
    _currentSubTabId = subcategory.subcategoryId;
    _currentSubTab = subcategory;
    if (notify) notifyListeners();
  }

  void updateSubTabBoxEmpty() {
    _currentSubTabId = " ";
    List<Item> items = new List<Item>();
    _currentSubTab =
        Subcategory(subcategoryId: " ", subcategory: " ", items: items);
    notifyListeners();
  }
}
