import 'package:flutter/material.dart';

final List catagory = ['Groserrt', 'Lent', 'Market', 'Food'];

class CatagoryBuild extends StatefulWidget {
  final IconData icon;
  final String title;

  const CatagoryBuild({super.key, required this.icon, required this.title});

  @override
  State<CatagoryBuild> createState() => _CatagoryBuildState();
}

class _CatagoryBuildState extends State<CatagoryBuild> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            widget.icon,
            size: 30,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16),
        ),

        // button to add a catagory
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add_rounded,
            size: 30,
          ),
        ),

        // catagory list
        children: catagory
            .map(
              (item) => ListTile(
                leading: const Icon(Icons.keyboard_arrow_right_rounded),
                title: Text(item),

                // button to remove a catagory
                trailing: IconButton(
                  onPressed: () {
                    catagory.remove(item);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline_rounded,
                    color: Colors.red,
                  ),
                ),
              ),
            )
            .toList());
  }
}
