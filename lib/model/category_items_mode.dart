// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ListOfcat {
  String? name;
  Icon? catIcon;

  ListOfcat({
    this.name,
    this.catIcon,
  });
}

ListOfcat mylist = ListOfcat();

List myMapList = [];

class MoneyModell {
  String price;

  String time;
  String date;
  String describtion;
  String frome;
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



// class CircularList<T> {
//   final List<T> _list = [];
//   final int _maxSize;

//   CircularList(this._maxSize);

//   void add(T item) {
//     if (_list.length == _maxSize) {
//       _list.removeAt(0);
//     }
//     _list.add(item);
//   }

//   List<T> get list => _list;

//   int get length => _list.length;
// }
