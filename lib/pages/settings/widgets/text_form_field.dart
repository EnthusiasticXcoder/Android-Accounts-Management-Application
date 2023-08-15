import 'package:flutter/material.dart';

typedef SaveCallback = void Function(String?);

class FormInputField extends StatelessWidget {
  final String value;
  final IconData icon;
  final String hint;
  final String lable;
  final SaveCallback? onSave;
  final GlobalKey<FormState> formKey;

  const FormInputField({
    super.key,
    required this.formKey,
    required this.value,
    required this.icon,
    required this.hint,
    required this.lable,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onTapOutside: (event) {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
        }
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) {
        formKey.currentState!.validate();
      },
      onEditingComplete: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
        }
        FocusScope.of(context).unfocus();
      },
      onSaved: onSave,
      validator: (val) =>
          val != null && val.isNotEmpty ? null : 'Required Field',
      decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintText: hint,
          fillColor: Colors.grey.shade100,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          label: Text(lable)),
    );
  }
}
