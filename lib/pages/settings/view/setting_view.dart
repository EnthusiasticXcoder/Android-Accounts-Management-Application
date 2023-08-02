import 'package:flutter/material.dart';
import 'package:my_app/pages/settings/widgets/accounts.dart';
import 'package:my_app/pages/settings/widgets/catagory.dart';

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
                subtitle: const Text('Import Data From Storage')),

            // share button
            buttonTile(icon: Icons.share, title: 'Share Data'),

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

  ListTile buttonTile(
      {required IconData icon,
      required String title,
      Widget? subtitle,
      IconData? traling}) {
    return ListTile(
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
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          traling,
          size: 30,
        ),
      ),
    );
  }
}
