import 'package:flutter/material.dart';
import 'package:my_app/pages/home/view/bargraph.dart';
import 'package:my_app/pages/home/view/linegraph.dart';
import 'package:my_app/pages/home/widgets/page_box.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:my_app/pages/home/widgets/widgets.dart';

import 'package:my_app/services/database_service.dart';
import 'package:my_app/utilities/generics/get_argument.dart';

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key});

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  late final PageController _pageController;
  late final DatabaseService _databaseService;

  @override
  void initState() {
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85);
    _databaseService = DatabaseService();
    _databaseService.open();
    super.initState();
  }

  @override
  void dispose() {
    _databaseService.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 79, 194, 248),
              Color.fromARGB(255, 41, 208, 246),
              Color.fromARGB(223, 130, 196, 250),
            ])),
          ),

          // Bottom Sliding Pannel
          SlidingUpPanel(
            body: StreamBuilder(
              stream: _databaseService.getstream(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return PageView(
                      controller: _pageController,
                      children: <Widget>[
                        PageBox(
                            child: Linegraph(
                          maxvalue: _databaseService.getmaxnode,
                          nodes: _databaseService.allNodes,
                        )),
                        PageBox(
                            child: BalanceNotationWidget(
                          balance: _databaseService.balance,
                          income: _databaseService.totalIncome,
                          expense: _databaseService.totalExpense,
                        )),
                        PageBox(
                            child: BarChart(
                          nodes: _databaseService.allNodes,
                        )),
                      ],
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
            parallaxEnabled: true,
            parallaxOffset: 0.8,
            panelBuilder: (scrollcontroller) {
              return TabbarWidget(
                verticalcontroller: scrollcontroller,
              );
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            minHeight: context.getminheight(),
            maxHeight: context.getmaxheight(),
          ),

          // Header Widget
          const Headwidget(),
        ],
      ),
    );
  }
}
