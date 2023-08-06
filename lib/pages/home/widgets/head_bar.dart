import 'package:flutter/material.dart';
import 'package:my_app/pages/settings/setting_view.dart';

class Headwidget extends StatelessWidget {
  final String name;
  final String? image;
  const Headwidget({super.key, required this.name, this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Name display
            Text(
              'Hi, $name!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // user circular avatar
            Hero(
              tag: 'Active User',
              child: CircleAvatar(
                foregroundImage: (image == null) ? null : AssetImage(image!),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsView(),
                    ));
                  },
                  icon: const Icon(Icons.person),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
