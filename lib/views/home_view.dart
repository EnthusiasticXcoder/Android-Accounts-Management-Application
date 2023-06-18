import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:my_app/utilities/vertical_controller.dart';
import 'package:my_app/views/widgets/balance_notation_widget.dart';
import 'package:my_app/views/widgets/tab_bar_widget.dart';

import 'package:my_app/services/database_service.dart';

import 'package:my_app/utilities/generics/get_argument.dart';

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key});

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  late final DatabaseService _databaseService;

  @override
  void initState() {
    _databaseService = DatabaseService();
    super.initState();
  }

  @override
  void dispose() {
    _databaseService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _databaseService.open(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Scaffold(
              backgroundColor: Colors.blue.shade500,
              body: Stack(
                children: <Widget>[
                  // Header Widget
                  _headerwidget(context),

                  // Bottom Sliding Pannel
                  SlidingUpPanel(
                    body: const BalanceNotationWidget(),
                    parallaxEnabled: true,
                    parallaxOffset: 0.75,
                    panelBuilder: (sc) {
                      VerticalController().setcontroller(sc);
                      return const TabbarWidget();
                    },
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(25)),
                    minHeight: context.getminheight(),
                    maxHeight: context.getmaxheight(),
                  ),
                ],
              ),
            );
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _headerwidget(BuildContext context) => const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Text(
            'Hi, Anshul!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}

