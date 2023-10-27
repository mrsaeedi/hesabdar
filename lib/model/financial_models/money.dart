import 'package:hesabdar/model/financial_models/category_items_model.dart';
import 'package:hive/hive.dart';
part 'money.g.dart';

@HiveType(typeId: 0)
class MoneyModell {
  @HiveField(1)
  String price;
  @HiveField(2)
  String time;
  @HiveField(3)
  String date;
  @HiveField(4)
  String describtion;
  @HiveField(5)
  String frome;
  @HiveField(6)
  ListOfcat listOfcat;
  MoneyModell({
    required this.price,
    required this.time,
    required this.date,
    required this.describtion,
    required this.frome,
    required this.listOfcat,
  });
}

@HiveType(typeId: 4)
class AddNewPay extends MoneyModell {
  AddNewPay({
    required super.price,
    required super.time,
    required super.date,
    required super.describtion,
    required super.frome,
    required super.listOfcat,
  });
}

@HiveType(typeId: 5)
class AddNewGet extends MoneyModell {
  AddNewGet({
    required super.price,
    required super.time,
    required super.date,
    required super.describtion,
    required super.frome,
    required super.listOfcat,
  });
}

@HiveType(typeId: 6)
class AddNewBudget extends MoneyModell {
  AddNewBudget({
    required super.price,
    required super.time,
    required super.date,
    required super.describtion,
    required super.frome,
    required super.listOfcat,
  });
}
