import 'package:flutter/material.dart';
import 'package:adminapp/models/category.dart';

class HomePageTabChange with ChangeNotifier {
  var _currentTabId = "";
  Category _currentTab;

  String get whichTab {
    print(_currentTabId);
    print("klllll");
    return _currentTabId;
  }

  Category get whichCategory {
    return _currentTab;
  }

  void updateTabBox(Category category, bool notify) {
    _currentTabId = category.categoryId;
    _currentTab = category;
    print(_currentTabId);
    print(_currentTab);
    if (notify) notifyListeners();
  }
}
