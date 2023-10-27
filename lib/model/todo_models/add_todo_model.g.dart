// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddTodoModelAdapter extends TypeAdapter<AddTodoModel> {
  @override
  final int typeId = 2;

  @override
  AddTodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddTodoModel(
      title: fields[1] as String,
      describtion: fields[2] as String,
      isDone: fields[3] as bool,
      date: fields[4] as String,
      time: fields[5] as String,
      importance: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AddTodoModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.describtion)
      ..writeByte(3)
      ..write(obj.isDone)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.importance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddTodoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
