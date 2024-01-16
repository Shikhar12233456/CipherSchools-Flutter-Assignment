import 'package:cipherx/back-end/box.dart';
import 'package:cipherx/models/Expence.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Service {
  var db = FirebaseFirestore.instance.collection("user");
  var dbStore = FirebaseFirestore.instance.collection("expence");
  Future<void> saveExpence(Expence expence, String email) async {
    expenceBox
        .put(DateTime.now().toString(), expence)
        .whenComplete(() => debugPrint("data stored"));
    await dbStore.doc(email).collection("expence").add(expence.toMap());
  }

  List<Expence> getExpence() {
    var tmp = Hive.box<Expence>('budget');
    List<Expence> expences = List.generate(
      tmp.length,
      (index) => tmp.getAt(index) as Expence,
    );
    return expences;
  }

  int getAccountBalance() {
    int curr = 0;
    for (var element in expenceBox.values) {
      Expence ele = element as Expence;
      int money = int.parse(ele.money.substring(1));
      curr = ele.money[0] == 'I' ? curr + money : curr - money;
    }
    return curr;
  }

  int getIncome() {
    int curr = 0;
    expenceBox.values.where((element) {
      Expence ele = element as Expence;
      return ele.money[0] == 'I';
    }).forEach((element) {
      Expence ele = element as Expence;
      curr += int.parse(ele.money.substring(1));
    });
    return curr;
  }

  int getExpance() {
    int curr = 0;
    expenceBox.values.where((element) {
      Expence ele = element as Expence;
      return ele.money[0] == 'E';
    }).forEach((element) {
      Expence ele = element as Expence;
      curr += int.parse(ele.money.substring(1));
    });
    return curr;
  }

  Future<void> clear() async {
    await expenceBox.clear();
  }

  Future<void> deleteAt(int index) async {
    await expenceBox.deleteAt(index);
  }

  Future<void> saveUserDataInfirebase(String name, String email) async {
    await db.add({"name": name, "email": email});
  }
}
