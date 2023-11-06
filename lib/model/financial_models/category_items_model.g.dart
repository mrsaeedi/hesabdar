// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_items_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListOfcatAdapter extends TypeAdapter<ListOfcat> {
  @override
  final int typeId = 1;

  @override
  ListOfcat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListOfcat(
      name: fields[1] as String?,
      catIcon: fields[2] as IconData?,
      catIndex: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ListOfcat obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.catIcon)
      ..writeByte(3)
      ..write(obj.catIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListOfcatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoresPayMoneyAdapter extends TypeAdapter<CategoresPayMoney> {
  @override
  final int typeId = 8;

  @override
  CategoresPayMoney read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoresPayMoney(
      name: fields[1] as String?,
      catIndex: fields[2] as int?,
      catList: fields[3] as List,
    );
  }

  @override
  void write(BinaryWriter writer, CategoresPayMoney obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.catIndex)
      ..writeByte(3)
      ..write(obj.catList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoresPayMoneyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
