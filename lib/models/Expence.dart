import 'package:hive/hive.dart';

part 'Expence.g.dart';

@HiveType(typeId: 1)
class Expence extends HiveObject {
  @HiveField(0)
  String category;
  @HiveField(1)
  String description;
  @HiveField(2)
  String type;
  @HiveField(3)
  String money;
  @HiveField(4)
  String dateTime;

  Expence(
      {required this.category,
      required this.description,
      required this.type,
      required this.money,
      required this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'description': description,
      'type': type,
      'money': money,
      'dateTime': dateTime
    };
  }

  factory Expence.fromMap(Map<String, dynamic> map) {
    return Expence(
        category: map['calegory'],
        description: map['description'],
        type: map['type'],
        money: map['money'],
        dateTime: map['dateTime']);
  }
}
// }
