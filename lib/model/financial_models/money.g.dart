// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyModellAdapter extends TypeAdapter<MoneyModell> {
  @override
  final int typeId = 0;

  @override
  MoneyModell read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneyModell(
      price: fields[1] as String,
      time: fields[2] as String,
      date: fields[3] as String,
      describtion: fields[4] as String,
      frome: fields[5] as String,
      listOfcat: fields[6] as ListOfcat,
      resultAsset: fields[7] as String,
      id: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MoneyModell obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.describtion)
      ..writeByte(5)
      ..write(obj.frome)
      ..writeByte(6)
      ..write(obj.listOfcat)
      ..writeByte(7)
      ..write(obj.resultAsset)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyModellAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddNewPayAdapter extends TypeAdapter<AddNewPay> {
  @override
  final int typeId = 4;

  @override
  AddNewPay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddNewPay(
      price: fields[1] as String,
      time: fields[2] as String,
      date: fields[3] as String,
      describtion: fields[4] as String,
      frome: fields[5] as String,
      listOfcat: fields[6] as ListOfcat,
      resultAsset: fields[7] as String,
      id: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddNewPay obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.describtion)
      ..writeByte(5)
      ..write(obj.frome)
      ..writeByte(6)
      ..write(obj.listOfcat)
      ..writeByte(7)
      ..write(obj.resultAsset)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddNewPayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddNewGetAdapter extends TypeAdapter<AddNewGet> {
  @override
  final int typeId = 5;

  @override
  AddNewGet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddNewGet(
      price: fields[1] as String,
      time: fields[2] as String,
      date: fields[3] as String,
      describtion: fields[4] as String,
      frome: fields[5] as String,
      listOfcat: fields[6] as ListOfcat,
      resultAsset: fields[7] as String,
      id: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddNewGet obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.describtion)
      ..writeByte(5)
      ..write(obj.frome)
      ..writeByte(6)
      ..write(obj.listOfcat)
      ..writeByte(7)
      ..write(obj.resultAsset)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddNewGetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddNewBudgetAdapter extends TypeAdapter<AddNewBudget> {
  @override
  final int typeId = 6;

  @override
  AddNewBudget read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddNewBudget(
      price: fields[1] as String,
      time: fields[2] as String,
      date: fields[3] as String,
      describtion: fields[4] as String,
      frome: fields[5] as String,
      listOfcat: fields[6] as ListOfcat,
      resultAsset: fields[7] as String,
      id: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddNewBudget obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.describtion)
      ..writeByte(5)
      ..write(obj.frome)
      ..writeByte(6)
      ..write(obj.listOfcat)
      ..writeByte(7)
      ..write(obj.resultAsset)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddNewBudgetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
