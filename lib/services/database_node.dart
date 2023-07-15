import 'package:flutter/foundation.dart';
import 'package:my_app/constants/crud_constants.dart';

@immutable
class DatabaseNote {
  final int amount;
  final String description;
  final int date;
  final int month;
  final int year;
  final int hour;
  final int minutes;
  final bool isincome;

  const DatabaseNote(
      {required this.amount,
      required this.description,
      required this.date,
      required this.month,
      required this.year,
      required this.hour,
      required this.minutes,
      required this.isincome});

  DatabaseNote.fromRow(Map<String, Object?> map)
      : amount = map[amountcolumn] as int,
        description = map[descridecolumn] as String,
        date = map[daycolumn] as int,
        month = map[monthcolumn] as int,
        year = map[yearcolumn] as int,
        hour = map[hourcolumn] as int,
        minutes = map[minutescolumn] as int,
        isincome = (map[statuscolumn] as int == 1) ? true : false;
}
