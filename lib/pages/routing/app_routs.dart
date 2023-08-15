import 'package:flutter/material.dart';
import 'package:my_app/home.dart';
import 'package:my_app/pages/regester/view/regester_view.dart';
import 'package:my_app/pages/settings/setting_view.dart';
import 'package:my_app/pages/settings/view/profile.dart';

class AppRouts {
  static const homepage = '/';
  static const registerpage = '/register';
  static const profilepage = '/profile';
  static const settingspage = '/settings';

  Route? onGenerateRouts(RouteSettings settings) {
    switch (settings.name) {
      case AppRouts.homepage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case AppRouts.registerpage:
        return MaterialPageRoute(
          builder: (context) => const RegisterView(),
        );
      case AppRouts.profilepage:
        return MaterialPageRoute(
          builder: (context) => ProfilePage(
            arguments: settings.arguments,
          ),
        );
      case AppRouts.settingspage:
        return MaterialPageRoute(
          builder: (context) => const SettingsView(),
        );
      default:
        return null;
    }
  }
}
