// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'category_items_model.g.dart';

@HiveType(typeId: 1)
class ListOfcat {
  @HiveField(1)
  String? name;
  @HiveField(2)
  IconData? catIcon;
  ListOfcat({
    this.name,
    this.catIcon,
  });
}
