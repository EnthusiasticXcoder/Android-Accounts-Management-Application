import 'package:flutter/material.dart';
import 'package:my_app/pages/home/home_view.dart';
import 'package:my_app/pages/regester/view/regester_view.dart';
import 'package:my_app/services/database_exceptions.dart';

import 'package:my_app/services/services.dart';
import 'widgets/widgets.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
                            active: activeUser!,
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
                  TileButton(
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
                  const TileButton(
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
}