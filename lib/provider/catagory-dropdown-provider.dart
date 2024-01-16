import 'package:flutter/material.dart';

class CategoryDropDownProvider extends ChangeNotifier {
  String _seletectedItem = "Category";
  String get selectedItem => _seletectedItem;
  static List<String> items = [
    "Category",
    "Shopping",
    "Subscription",
    "Travel",
    "Food",
  ];
  void setSelectedItem(String newValue) {
    _seletectedItem = newValue;
    notifyListeners();
  }
}
