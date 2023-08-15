import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app/pages/settings/widgets/should_delete.dart';
import 'package:my_app/services/services.dart';

import '../widgets/text_form_field.dart';

class ProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Object? arguments;

  ProfilePage({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    final activeuser = arguments as DatabaseUser;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
            ShouldDelete.showDialog(context, activeuser);
          },
        ),
        body: Stack(
          children: [
            // Label Create Account
            Container(
              padding: EdgeInsets.only(left: width * 0.15, top: height * 0.08),
              child: const Text(
                'User\nProfile',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),

            // Form Filet entry Input
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(top: height * 0.36),
                margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  children: [
                    // margin
                    SizedBox(height: height * 0.05),

                    // Text field for name
                    FormInputField(
                      formKey: _formKey,
                      onSave: (newValue) async {
                        if (newValue != activeuser.name) {
                          final name = newValue;
                          // update user's Name
                          context.read<NodeBloc>().add(
                                NodeEventUpdateUser(name: name),
                              );
                        }
                      },
                      value: activeuser.name,
                      lable: 'Name',
                      hint: 'eg. Your Name',
                      icon: Icons.person,
                    ),

                    // margin
                    SizedBox(height: height * 0.02),

                    // text field for description
                    FormInputField(
                      formKey: _formKey,
                      onSave: (newValue) async {
                        if (newValue != activeuser.info) {
                          final info = newValue;
                          // update user's Name
                          context.read<NodeBloc>().add(
                                NodeEventUpdateUser(info: info),
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
              top: height * 0.14,
              right: width * 0.05,
              child: Hero(
                tag: 'Active User',
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey.withAlpha(240),
                  radius: 90.0,
                  child: const Icon(
                    Icons.person,
                    size: 130.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
