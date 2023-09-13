import 'package:flutter/foundation.dart' show immutable;
import 'package:my_app/constants/crud_constants.dart';

@immutable
class Filters {
  final Catagory catagory;
  final List<Catagory> subcatagory;

  const Filters({required this.catagory, required this.subcatagory});

  @override
  String toString() => '${catagory.toString()} => ${subcatagory.toString()}';
}

@immutable
class Catagory {
  final int id;
  final String name;

  const Catagory({required this.id, required this.name});

  Catagory.fromRow(Map<String, Object?> map)
      : id = map[idcolumn] as int,
        name = map[catagorynamecolumn] as String;

  @override
  String toString() => '$id , $name';
}

class FilterBy {
  int? date;
  int year;
  int? month;
  int? catagory;
  int? subcatagory;

  FilterBy({
    this.date,
    required this.year,
    this.month,
    this.catagory,
    this.subcatagory,
  });

  @override
  String toString() {
    return '$catagory $subcatagory $year $month $date';
  }

  void setNull() {
    catagory = null;
    subcatagory = null;
    month = null;
    date = null;
  }
}
