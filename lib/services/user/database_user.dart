import 'package:my_app/constants/crud_constants.dart';

class DatabaseUser {
  final int id;
  final String name;
  final String info;
  final String? imagePath;
  bool isactive;

  DatabaseUser(
      {required this.id,
      required this.name,
      required this.info,
      this.imagePath,
      required this.isactive});

  DatabaseUser.fromrow(Map<String, Object?> map)
      : id = map[idcolumn] as int,
        name = map[namecolumn] as String,
        info = map[infocolumn] as String,
        imagePath = map[imageColumn] as String?,
        isactive = (map[isactivecolumn] as int == 1) ? true : false;

  @override
  String toString() => '$id $name $info';
}
