import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/services/database_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/widgets.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // margin
            const SizedBox(height: 20.0),
            // profile
            const Account(),
            // Devider
            const Divider(height: 30),
            // Import Button
            buttonTile(
              icon: Icons.drive_file_move_outline,
              title: 'Import Data',
              subtitle: const Text('Import Data From Storage'),
              onPress: import,
            ),

            // share button
            buttonTile(
              icon: Icons.share,
              title: 'Share Data',
              onPress: share,
            ),

            // catagory
            const CatagoryBuild(
              icon: Icons.sort,
              title: 'Catagory',
            ),

            // sub catagory
            const CatagoryBuild(
              icon: Icons.list_alt,
              title: 'Sub Catagory',
            ),
          ],
        ),
      ),
    );
  }

  ListTile buttonTile({
    required IconData icon,
    required String title,
    Widget? subtitle,
    VoidCallback? onPress,
  }) {
    return ListTile(
      onTap: onPress,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: 30,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      subtitle: subtitle,
    );
  }
}

void share() async {
  final docsPath = await getApplicationDocumentsDirectory();
  final dbPath = join(docsPath.path, dbName);

  await Share.shareXFiles([XFile(dbPath)]);
}

void import() async {
  final filePath = await FilePicker.platform.pickFiles();
  final path = filePath!.files.first.path;

  final docsPath = await getApplicationDocumentsDirectory();
  final dbPath = join(docsPath.path, dbName);
  
  await File(dbPath).delete();
  await File(path!).copy(dbPath);

  await DatabaseService().restartDatabase(path);
}
