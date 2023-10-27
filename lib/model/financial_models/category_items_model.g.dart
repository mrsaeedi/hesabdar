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
    );
  }

  @override
  void write(BinaryWriter writer, ListOfcat obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.catIcon);
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
