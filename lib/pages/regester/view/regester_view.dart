import 'package:flutter/material.dart';

import 'package:my_app/pages/home/home_view.dart';
import 'package:my_app/services/services.dart';
import '../widgets/editable_profile.dart';

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
              image: AssetImage('asset/images/login.png'), fit: BoxFit.fill)),
      child: Scaffold(
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
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.32),
                margin: const EdgeInsets.only(left: 35, right: 35),
                child: Column(children: [
                  // margin
                  const SizedBox(height: 30),
                  // name text field entry
                  entryField(
                      controller: _nameController,
                      hint: "Name",
                      icon: Icons.person),
                  // margin
                  const SizedBox(height: 30),
                  // info field entry
                  entryField(
                      controller: _infoController,
                      hint: "Info",
                      icon: Icons.info_outline),
                  // margin
                  const SizedBox(height: 40),
                  // confirm button
                  ListTile(
                    tileColor: Colors.transparent,
                    // lable button
                    leading: const Text(
                      'Confirm',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontWeight: FontWeight.w700),
                    ),
                    // button to conform
                    trailing: IconButton(
                        color: Colors.white,
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xff4c505b)),
                            fixedSize:
                                MaterialStatePropertyAll(Size.fromRadius(27))),
                        onPressed: () async {
                          await createUser(
                            username: _nameController.text.toString(),
                            info: _infoController.text.toString(),
                            imagePath: _imagePath.value,
                          );
                          await initialiseDatabase().then((value) =>
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const MyHomeView(),
                                ),
                                (route) => false,
                              ));
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                        )),
                  )
                ]),
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

  TextField entryField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.blueGrey),
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
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
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.blueGrey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
