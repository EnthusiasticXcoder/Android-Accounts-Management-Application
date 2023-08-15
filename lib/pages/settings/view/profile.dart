import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app/pages/regester/widgets/editable_profile.dart';
import 'package:my_app/pages/routing/app_routs.dart';
import 'package:my_app/services/services.dart';

import '../widgets/text_form_field.dart';

class ProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Object? arguments;

  ProfilePage({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    final activeuser = arguments as DatabaseUser;
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/images/login.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            // delete profile
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              child: const Icon(Icons.delete_forever),
              onPressed: () {
                // Deleting Current Active User
                final userId = activeuser.id;
                context.read<NodeBloc>().add(NodeEventDeleteUser(userId));
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouts.homepage,
                  (route) => route.settings.name == AppRouts.homepage,
                );
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
              Form(
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
                      FormInputField(
                        formKey: _formKey,
                        onSave: (newValue) async {
                          if (newValue != activeuser.name) {
                            final id = activeuser.id;
                            final name = newValue;
                            // update user's Name
                            context.read<NodeBloc>().add(
                                  NodeEventUpdateUser(
                                    id: id,
                                    name: name,
                                  ),
                                );
                          }
                        },
                        value: activeuser.name,
                        lable: 'Name',
                        hint: 'eg. Your Name',
                        icon: Icons.person,
                      ),

                      // margin
                      const SizedBox(height: 20),

                      // text field for description
                      FormInputField(
                        formKey: _formKey,
                        onSave: (newValue) async {
                          if (newValue != activeuser.info) {
                            final id = activeuser.id;
                            final info = newValue;
                            // update user's Name
                            context.read<NodeBloc>().add(
                                  NodeEventUpdateUser(
                                    id: id,
                                    info: info,
                                  ),
                                );
                          }
                        },
                        value: activeuser.info,
                        lable: 'Info',
                        hint: 'eg. Personal',
                        icon: Icons.info_outline,
                      ),
                    ],
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
}
