import 'package:flutter/material.dart';
import 'package:my_app/views/widgets/head_bar_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:my_app/utilities/controllers/vertical_controller.dart';
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
    _databaseService.open();
    super.initState();
  }

  @override
  void dispose() {
    _databaseService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 0, 174, 255),
              Colors.lightBlue.shade400,
              Colors.blue.shade500,
            ])),
          ),
          // Header Widget
          const Headwidget(),

          // Bottom Sliding Pannel
          SlidingUpPanel(
            body: FutureBuilder(
              future: _databaseService.open(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return const BalanceNotationWidget();
                  default:
                    return const BalanceNotationWidget();
                }
              },
            ),
            parallaxEnabled: true,
            parallaxOffset: 0.75,
            panelBuilder: (sc) {
              VerticalController().setcontroller(sc);
              return const TabbarWidget();
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            minHeight: context.getminheight(),
            maxHeight: context.getmaxheight(),
          ),
        ],
      ),
    );
  }
}
