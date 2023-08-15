import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/pages/regester/widgets/widgets.dart';
import 'package:my_app/services/services.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _nameController;
  late final TextEditingController _infoController;
  late final ValueNotifier _imagePath;

  @override
  void initState() {
    _nameController = TextEditingController();
    _infoController = TextEditingController();
    _imagePath = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _infoController.dispose();
    _imagePath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Stack(
          children: [
            // Label Create Account
            Container(
              padding: const EdgeInsets.only(left: 35, top: 65),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),

            // Name Form
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.32),
              margin: const EdgeInsets.only(left: 35, right: 35),
              child: Column(
                children: [
                  // margin
                  const SizedBox(height: 30),
                  // name text field entry
                  EntryField(
                      controller: _nameController,
                      hint: "Name",
                      icon: Icons.person),
                  // margin
                  const SizedBox(height: 30),
                  // info field entry
                  EntryField(
                      controller: _infoController,
                      hint: "Info",
                      icon: Icons.info_outline),
                  // margin
                  const SizedBox(height: 40),
                  // confirm button
                  ForwardLabelButton(
                    onPress: () {
                      final userName = _nameController.text.toString();
                      final info = _infoController.text.toString();
                      final imagePath = _imagePath.value;
                      // Create User event
                      context.read<NodeBloc>().add(
                            NodeEventCreateUser(
                              username: userName,
                              info: info,
                              imagePath: imagePath,
                            ),
                          );
                      _nameController.clear();
                      _infoController.clear();
                      final navigator = Navigator.of(context);
                      if (navigator.canPop()) navigator.pop();
                    },
                  )
                ],
              ),
            ),

            // Profile Photo selector
            Positioned(
              top: MediaQuery.of(context).size.height * 0.10,
              right: MediaQuery.of(context).size.width * 0.05,
              child: EditableProfile(
                imagePath: _imagePath,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
