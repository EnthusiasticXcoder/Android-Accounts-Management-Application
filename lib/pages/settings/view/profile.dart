import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.delete_forever),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Hero(
                tag: 'Active User',
                child: GestureDetector(
                  onTap: () {},
                  child: const CircleAvatar(
                    radius: 90.0,
                    child: Icon(
                      Icons.person,
                      size: 130.0,
                    ),
                  ),
                ),
              ),

              // margin
              const SizedBox(height: 40),

              // Text field for name
              formInput(
                context: context,
                value: 'Anshul Verma',
                lable: 'Name',
                hint: 'eg. Your Name',
                icon: Icons.person,
              ),

              // margin
              const SizedBox(height: 20),

              // text field for description
              formInput(
                context: context,
                value: 'Business',
                lable: 'Info',
                hint: 'eg. Personal',
                icon: Icons.info_outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField formInput(
      {required BuildContext context,
      required String value,
      required IconData icon,
      required String hint,
      required String lable}) {
    return TextFormField(
      initialValue: value,
      onTapOutside: (event) {
        _formKey.currentState!.validate();
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) {
        _formKey.currentState!.validate();
      },
      onEditingComplete: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
        }
      },
      onSaved: (newValue) {},
      validator: (val) =>
          val != null && val.isNotEmpty ? null : 'Required Field',
      decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintText: hint,
          label: Text(lable)),
    );
  }
}
