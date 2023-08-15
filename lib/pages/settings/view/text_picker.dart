import 'package:flutter/material.dart';

Future<String?> showTextPicker(BuildContext context) async {
  String? text;

  final controller = TextEditingController();

  final size = MediaQuery.sizeOf(context);
  await showDialog(
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Enter Catagory Name',
          style: TextStyle(fontSize: 18),
        ),
        contentPadding: EdgeInsets.only(
            top: size.height * 0.065,
            left: size.width * 0.05,
            right: size.width * 0.05,
            bottom: size.height * 0.04),
        content: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            autofocus: true,
            controller: controller,
            validator: (value) => (value!.isEmpty) ? 'Required Field' : null,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: size.width * 0.01),
                hintText: 'Catagory Name...',
                border: OutlineInputBorder(
                    gapPadding: 0, borderRadius: BorderRadius.circular(12))),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  text = controller.text;
                  FocusScope.of(context).unfocus();
                }
                Navigator.of(context).pop();
              },
              child: const Text('Done'))
        ],
      );
    },
    context: context,
  );
  return text;
}
