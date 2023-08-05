import 'package:flutter/material.dart';

class EditableProfile extends StatelessWidget {
  final ValueNotifier? imagePath;
  const EditableProfile({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'Active User',
          child: GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey.withAlpha(240),
              radius: 90.0,
              foregroundImage: (imagePath?.value == null)
                  ? null
                  : AssetImage(imagePath?.value),
              child: const Icon(
                Icons.person,
                size: 130.0,
              ),
            ),
          ),
        ),
        //Edit for progile photo
        Positioned(
          bottom: 0,
          left: -10,
          child: MaterialButton(
            elevation: 1,
            onPressed: () {
              imagePath?.value = 'Path/To/Image';
            },
            shape: const CircleBorder(),
            color: Colors.white,
            child: Icon(Icons.edit, color: Colors.blue.shade400),
          ),
        ),
      ],
    );
  }
}
