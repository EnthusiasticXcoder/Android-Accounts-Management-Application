import 'package:flutter/material.dart';

class Headwidget extends StatelessWidget {
  final String name;
  final String? image;
  final VoidCallback navigate;
  const Headwidget({
    super.key,
    required this.name,
    this.image,
    required this.navigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
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
                onPressed: navigate,
                icon: const Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
