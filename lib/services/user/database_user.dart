import 'package:my_app/constants/crud_constants.dart';

class DatabaseUser {
  final int id;
  final String name;
  final String info;
  bool isactive;

  DatabaseUser(
      {required this.id,
      required this.name,
      required this.info,
      required this.isactive});

  DatabaseUser.fromrow(Map<String, Object?> map)
      : id = map[idcolumn] as int,
        name = map[namecolumn] as String,
        info = map[infocolumn] as String,
        isactive = (map[isactivecolumn] as int == 1) ? true : false;

  @override
  String toString() => '$id $name $info';
}
