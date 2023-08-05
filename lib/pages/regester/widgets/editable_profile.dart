import 'package:flutter/material.dart';
import 'package:my_app/pages/regester/widgets/image_picker.dart';

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
            onTap: () {
              showImagePicker(context);
            },
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
        //Edit for profile photo
        Positioned(
          bottom: 0,
          left: -10,
          child: MaterialButton(
            padding: const EdgeInsets.all(8.0),
            elevation: 1,
            onPressed: () {
              imagePath?.value = 'Path/To/Image';
              showImagePicker(context);
            },
            shape: const CircleBorder(),
            color: Colors.lightBlue.shade200,
            child: const Icon(Icons.photo_camera_sharp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
