// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Expence.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenceAdapter extends TypeAdapter<Expence> {
  @override
  final int typeId = 1;

  @override
  Expence read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expence(
      category: fields[0] as String,
      description: fields[1] as String,
      type: fields[2] as String,
      money: fields[3] as String,
      dateTime: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Expence obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.money)
      ..writeByte(4)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
