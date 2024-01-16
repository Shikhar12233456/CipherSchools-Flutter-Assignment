import 'package:cipherx/back-end/save-data.dart';
import 'package:cipherx/models/Expence.dart';
import 'package:flutter/material.dart';

class ExpenceDataProvider extends ChangeNotifier {
  List<Expence> get data => Service().getExpence();

  void notifyListeners() {
    super.notifyListeners();
  }
}
