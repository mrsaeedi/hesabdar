import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class IconDataAdapter extends TypeAdapter<IconData> {
  @override
  final int typeId = 7;

  @override
  IconData read(BinaryReader reader) {
    final codePoint = reader.readInt();
    final fontFamily = reader.readString();
    final fontPackage = reader.readString();
    return IconData(
      codePoint,
      fontFamily: fontFamily,
      fontPackage: fontPackage,
    );
  }

  @override
  void write(BinaryWriter writer, IconData obj) {
    writer.writeInt(obj.codePoint);
    writer.writeString(obj.fontFamily.toString());
    writer.writeString(obj.fontPackage.toString());
  }
}
