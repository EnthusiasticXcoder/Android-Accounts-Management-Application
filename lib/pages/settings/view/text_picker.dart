import 'package:flutter/material.dart';

Future<String?> showTextPicker(BuildContext context) async {
  String? text;

  final controller = TextEditingController();
  await showDialog(
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Enter Catagory Name',
          style: TextStyle(fontSize: 18),
        ),
        contentPadding: const EdgeInsets.only(
            top: 50.0, left: 18.0, right: 18.0, bottom: 24.0),
        content: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            autofocus: true,
            controller: controller,
            validator: (value) => (value!.isEmpty) ? 'Required Field' : null,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
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
