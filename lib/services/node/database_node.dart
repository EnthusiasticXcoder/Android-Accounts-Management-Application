import 'package:flutter/foundation.dart' show immutable;
import 'package:my_app/constants/crud_constants.dart';

@immutable
class DatabaseNode {
  final int id;
  final int userId;
  final int amount;
  final int catogary;
  final int subCatagory;
  final int date;
  final int month;
  final int year;
  final int hour;
  final int minutes;
  final bool isincome;

  const DatabaseNode(
      {required this.id,
      required this.amount,
      required this.userId,
      required this.catogary,
      required this.subCatagory,
      required this.date,
      required this.month,
      required this.year,
      required this.hour,
      required this.minutes,
      required this.isincome});

  DatabaseNode.fromRow(Map<String, Object?> map)
      : id = map[idcolumn] as int,
        amount = map[amountcolumn] as int,
        userId = map[userIdcolumn] as int,
        catogary = map[catagoryIdcolumn] as int,
        subCatagory = map[subcatagoryIdcolumn] as int,
        date = map[datecolumn] as int,
        month = map[monthcolumn] as int,
        year = map[yearcolumn] as int,
        hour = map[hourcolumn] as int,
        minutes = map[minutescolumn] as int,
        isincome = (map[isIncomecolumn] as int == 1) ? true : false;
}
