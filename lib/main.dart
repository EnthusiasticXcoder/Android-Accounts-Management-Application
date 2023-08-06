import 'package:flutter/material.dart';

import 'package:my_app/services/services.dart';

import 'pages/home/home_view.dart';
import 'pages/regester/view/regester_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initialiseDatabase().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true),
      home: (allUsers.isEmpty) ? const RegisterView() : const MyHomeView(),
    );
  }
}
