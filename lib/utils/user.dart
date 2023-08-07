import 'package:flutter/widgets.dart' show ValueNotifier;
import 'package:my_app/services/services.dart';

// User Services

ValueNotifier<DatabaseUser?> get userValueNotifier {
  // Get Node Value Notifier
  final service = DatabaseService();
  return service.userValueNotifier;
}

Iterable<DatabaseUser> get allUsers {
  // Get All Users
  final service = DatabaseService();
  final allUsers = service.getAllUsers;
  return allUsers;
}

Future<void> changeActiveUser(DatabaseUser user) async {
  // Change The status of all the users and mark new active user
  final service = DatabaseService();
  await service.changeActiveUser(user);
}

Future<void> createUser({
  required String username,
  required String info,
  String? imagePath,
}) async {
  // Create new user
  final service = DatabaseService();
  service.createUser(username: username, info: info, imagePath: imagePath);
}

Future<void> deleteUser(int id) async {
  // delete Data of current user
  final service = DatabaseService();
  await service.deleteUser(id);
}

Future<void> updateUser(
    {required int id, String? name, String? info, String? imagePath}) async {
  // update data of current user
  final service = DatabaseService();

  await service.updateUser(
      id: id, name: name, info: info, imagePath: imagePath);
}
