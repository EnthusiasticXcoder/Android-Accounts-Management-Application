import 'package:flutter/material.dart';
import 'package:my_app/pages/settings/view/setting_view.dart';
import 'package:my_app/services/get_shared_value.dart';

class Headwidget extends StatefulWidget {
  const Headwidget({super.key});

  @override
  State<Headwidget> createState() => _HeadwidgetState();
}

class _HeadwidgetState extends State<Headwidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Name display
            FutureBuilder(
              future: GetSharedValue().setinstance(),
              builder: (context, snapshot) => Text(
                'Hi, ${GetSharedValue().userName}!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // user circular avatar
            Hero(
              tag: 'Active User',
              child: CircleAvatar(
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
