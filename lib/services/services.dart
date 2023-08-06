import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/services/database_exceptions.dart';
import 'package:my_app/services/database_service.dart';
import 'package:my_app/services/filter/database_filter.dart';
import 'package:my_app/services/node/database_node.dart';
import 'package:my_app/services/user/database_user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

export './user/database_user.dart';
export './node/database_node.dart';
export './filter/database_filter.dart';

Future<void> initialiseDatabase() async {
  // Initialise Database
  final service = DatabaseService();
  try {
    await service.initialiseUser();
  } on NoUsersFoundinDatabase {
    return;
  }
  await service.initialiseNodes();
}

ValueNotifier<Iterable<DatabaseNode>> get nodeValueNotifier {
  // Get Node Value Notifier
  final service = DatabaseService();
  return service.nodeValueLisnable;
}

int get maxNodeAmount {
  // Get The Amount Of DatabaseNode Which Has Maximum Amount Value
  final service = DatabaseService();
  return service.maxNodeAmount;
}

int get sumIncome {
  // Get The Sum of Amounts Of all Income Node
  final service = DatabaseService();
  return service.sumIncome;
}

int get sumExpense {
  // Get The Sum of Amounts Of all Expense Node
  final service = DatabaseService();
  return service.sumExpense;
}

int get sumBalance {
  // Get The Sum of Amounts Of all Nodes with +vs income and -vs expense
  final service = DatabaseService();
  return service.sumBalance;
}

Future<void> createNode({
  required int amount,
  required int catagoryId,
  required int subCatagoryId,
  required int isIncome,
}) async {
  // Create a New Node
  final service = DatabaseService();
  service.createNode(
      amount: amount,
      catagoryId: catagoryId,
      subCatagoryId: subCatagoryId,
      isIncome: isIncome);
}

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
// filters Functions

List<Filters> get allFilters {
  // Get List of all the catagories and their sub catagory
  final service = DatabaseService();
  return service.filters;
}

Future<void> createCatagory({required String name}) async {
  // Create A new Catagory
  final service = DatabaseService();
  await service.createCatagory(name);
}

Future<void> createSubCatagory(
    {required int catagoryId, required String name}) async {
  // Create A new sub Catagory
  final service = DatabaseService();
  await service.createSubCatagory(catagoryId: catagoryId, name: name);
}

Future<void> removeCatagory(int catagoryId) async {
  // Remove A catagory and all its sub catagory
  final service = DatabaseService();
  await service.removeCatagory(catagoryId);
}

Future<void> removeSubcatagory(
    {required int catagoryId, required int subCatagoryId}) async {
  // remove sub catagory of a perticular catagory
  final service = DatabaseService();
  await service.removeSubcatagory(
      catagoryId: catagoryId, subCatagoryId: subCatagoryId);
}

// import export settings function
Future<void> share() async {
  final docsPath = await getApplicationDocumentsDirectory();
  final dbPath = join(docsPath.path, dbName);

  await Share.shareXFiles([XFile(dbPath)]);
}

Future<void> import() async {
  final filePath = await FilePicker.platform.pickFiles();
  final path = filePath!.files.first.path;

  final docsPath = await getApplicationDocumentsDirectory();
  final dbPath = join(docsPath.path, dbName);

  await File(dbPath).delete();
  await File(path!).copy(dbPath);

  final service = DatabaseService();
  await service.restoreDatabase(path);
}
