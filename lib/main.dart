import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/pages/routing/app_routs.dart';

import 'services/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(appRouts: AppRouts()));
}

class MyApp extends StatelessWidget {
  final AppRouts? appRouts;
  const MyApp({super.key, this.appRouts});

  @override
  Widget build(BuildContext context) {
    final service = DatabaseService();
    return MultiBlocProvider(
      providers: [
        BlocProvider<NodeBloc>(
          create: (context) => NodeBloc(service),
        ),
        BlocProvider<MainBloc>(
          create: (context) => MainBloc(service),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            useMaterial3: true),
        onGenerateRoute: (settings) => appRouts?.onGenerateRouts(settings),
      ),
    );
  }
}
