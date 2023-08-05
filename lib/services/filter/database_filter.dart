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
