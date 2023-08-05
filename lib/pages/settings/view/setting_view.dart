import 'package:flutter/material.dart';
import 'package:my_app/pages/home/view/home_view.dart';
import 'package:my_app/pages/regester/view/regester_view.dart';
import 'package:my_app/services/database_exceptions.dart';

import 'package:my_app/services/services.dart';
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
      backgroundColor: const Color.fromARGB(210, 213, 240, 251),
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // margin
            const SizedBox(height: 30),
            // Profile settings
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child:
                  // profile
                  ValueListenableBuilder(
                      valueListenable: userValueNotifier,
                      builder: (context, activeUser, _) => Account(
                            active: activeUser,
                            accounts: allUsers,
                          )),
            ),

            // other settings
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Import Button
                  buttonTile(
                    icon: Icons.drive_file_move_outline,
                    title: 'Import Data',
                    subtitle: const Text('Import Data From Storage'),
                    onPress: () async {
                      try {
                        await import().then((value) =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyHomeView(),
                            )));
                      } on NoUsersFoundinDatabase {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterView(),
                        ));
                      }
                    },
                  ),

                  // share button
                  buttonTile(
                    icon: Icons.share,
                    title: 'Share Data',
                    onPress: share,
                  ),
                ],
              ),
            ),
            // catagory config
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child:
                  // catagory
                  CatagoryBuild(filters: allFilters),
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
