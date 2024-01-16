import 'package:flutter/material.dart';

class TypeDropDownProvider extends ChangeNotifier {
  String _seletectedItem = "Wallet";
  String get selectedItem => _seletectedItem;
  static List<String> items = [
    "Wallet",
    "Bank",
    "UPI",
    "XYZ",
    "XYZ2",
  ];
  void setSelectedItem(String newValue) {
    _seletectedItem = newValue;
    notifyListeners();
  }
}
