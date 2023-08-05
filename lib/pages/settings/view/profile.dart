import 'package:flutter/material.dart';
import 'package:my_app/pages/regester/view/regester_view.dart';
import 'package:my_app/pages/regester/widgets/editable_profile.dart';
import 'package:my_app/services/database_exceptions.dart';
import 'package:my_app/services/services.dart'
    show DatabaseUser, updateUser, deleteUser;

typedef SaveCallback = void Function(String?);

class ProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final DatabaseUser activeuser;

  ProfilePage({super.key, required this.activeuser});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/images/login.png'), fit: BoxFit.fill)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            // delete profile
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              child: const Icon(Icons.delete_forever),
              onPressed: () async {
                try {
                  await deleteUser(activeuser.id)
                      .then((value) => Navigator.of(context).pop());
                } on AllUserDeleted {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const RegisterView(),
                      ),
                      (route) => false);
                }
              },
            ),
            body: Stack(children: [
              // Label Create Account
              Container(
                padding: const EdgeInsets.only(left: 35, top: 65),
                child: const Text(
                  'User\nProfile',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),

              // Form Filet entry Input
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.36),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        // margin
                        const SizedBox(height: 40),

                        // Text field for name
                        formInput(
                          onSave: (newValue) async {
                            if (newValue != activeuser.name) {
                              await updateUser(
                                  id: activeuser.id, name: newValue);
                            }
                          },
                          context: context,
                          value: activeuser.name,
                          lable: 'Name',
                          hint: 'eg. Your Name',
                          icon: Icons.person,
                        ),

                        // margin
                        const SizedBox(height: 20),

                        // text field for description
                        formInput(
                          onSave: (newValue) async {
                            if (newValue != activeuser.info) {
                              await updateUser(
                                  id: activeuser.id, info: newValue);
                            }
                          },
                          context: context,
                          value: activeuser.info,
                          lable: 'Info',
                          hint: 'eg. Personal',
                          icon: Icons.info_outline,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // profile pic
              Positioned(
                top: MediaQuery.of(context).size.height * 0.14,
                right: MediaQuery.of(context).size.width * 0.05,
                child: const EditableProfile(),
              ),
            ])));
  }

  TextFormField formInput({
    required BuildContext context,
    required String value,
    required IconData icon,
    required String hint,
    required String lable,
    SaveCallback? onSave,
  }) {
    return TextFormField(
      initialValue: value,
      onTapOutside: (event) {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
        }
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) {
        _formKey.currentState!.validate();
      },
      onEditingComplete: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
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
