import 'package:flutter/foundation.dart' show immutable;
import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/services/filter/database_filter.dart';

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

  bool cheackFilter(FilterBy filter) {
    bool factor1 =
        (filter.catagory == null) ? true : (catogary == filter.catagory);

    bool factor2 = (filter.subcatagory == null)
        ? true
        : (subCatagory == filter.subcatagory);

    bool factor3 = (filter.date == null) ? true : (date == filter.date);
    bool factor4 = (filter.month == null) ? true : (month == filter.month);
    bool factor5 = (year == filter.year);

    return factor1 && factor2 && factor3 && factor4 && factor5;
  }
}
