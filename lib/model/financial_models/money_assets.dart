// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'money_assets.g.dart';

@HiveType(typeId: 9)
class MoneyAssets {
  @HiveField(1)
  String name;
  @HiveField(2)
  int inventory;
  @HiveField(3)
  List? transactionList = [];
  MoneyAssets({
    required this.name,
    required this.inventory,
    this.transactionList,
  });
}
