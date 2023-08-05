import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showImagePicker(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            //pick profile picture label
            ListTile(
              title: const Text('Pick Profile Picture',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              trailing: IconButton(
                  // Function to Remove Profile Pic
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black54,
                  )),
            ),

            //for adding some space
            const SizedBox(height: 10.0),

            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //pick from gallery button
                imageButton(
                    context: context,
                    text: 'Camera',
                    icon: Icons.camera_alt_rounded,
                    onPress: () async {
                      final ImagePicker picker = ImagePicker();

                      // Pick an image
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 80);
                      if (image != null) {
                        //_image = image.path;

                        // for hiding bottom sheet
                        Navigator.pop(context);
                      }
                    }),

                //take picture from camera button
                imageButton(
                    context: context,
                    text: 'Gallery',
                    icon: Icons.image_rounded,
                    onPress: () async {
                      final ImagePicker picker = ImagePicker();
                      
                      // Pick an image
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 80);
                      if (image != null) {
                        //_image = image.path;

                        // for hiding bottom sheet
                        Navigator.pop(context);
                      }
                    })
              ],
            ),
            //for adding some space
            const SizedBox(height: 20.0),
          ],
        );
      });
}

Widget imageButton({
  required BuildContext context,
  required VoidCallback onPress,
  required IconData icon,
  required String text,
}) {
  return Column(
    children: [
      OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(18.0)),
          onPressed: onPress,
          child: Icon(
            icon,
            size: 40,
          )),
      Text(
        text,
        style: const TextStyle(height: 2.5, color: Colors.black54),
      ),
    ],
  );
}
