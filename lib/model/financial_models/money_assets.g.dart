part of 'money_assets.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyAssetsAdapter extends TypeAdapter<MoneyAssets> {
  @override
  final int typeId = 9;

  @override
  MoneyAssets read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneyAssets(
      name: fields[1] as String,
      inventory: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MoneyAssets obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.inventory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyAssetsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
