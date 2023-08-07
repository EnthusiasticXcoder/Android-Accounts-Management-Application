import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:my_app/constants/crud_constants.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../services/services.dart';

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
