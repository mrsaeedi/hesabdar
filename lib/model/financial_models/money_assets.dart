// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'money_assets.g.dart';

@HiveType(typeId: 9)
class MoneyAssets extends HiveObject {
  @HiveField(1)
  String name;
  @HiveField(2)
  int inventory;

  MoneyAssets({
    required this.name,
    required this.inventory,
  });
}
