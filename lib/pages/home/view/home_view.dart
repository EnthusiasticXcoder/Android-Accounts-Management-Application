import 'package:flutter/material.dart';
import 'package:my_app/services/services.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:my_app/pages/home/view/bargraph.dart';
import 'package:my_app/pages/home/view/linegraph.dart';
import 'package:my_app/pages/home/widgets/widgets.dart';

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key});

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85);
    super.initState();
  }

  @override
  void dispose() {
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
            body: PageView(
              controller: _pageController,
              children: <Widget>[
                // linggraph plot
                PageBox(
                  child: ValueListenableBuilder(
                    valueListenable: nodeValueNotifier,
                    builder: (context, value, child) => Linegraph(
                      maxvalue: maxNodeAmount,
                      nodes: allNodes,
                    ),
                  ),
                ),
                // balance Display widget
                PageBox(
                  child: ValueListenableBuilder(
                    valueListenable: nodeValueNotifier,
                    builder: (context, value, child) => BalanceNotationWidget(
                      balance: sumBalance,
                      income: sumIncome,
                      expense: sumExpense,
                    ),
                  ),
                ),

                // Bargraph plot
                PageBox(
                    child: ValueListenableBuilder(
                  valueListenable: nodeValueNotifier,
                  builder: (context, value, child) => BarChart(
                    nodes: allNodes,
                  ),
                )),
              ],
            ),
            parallaxEnabled: true,
            parallaxOffset: 0.8,
            panelBuilder: (scrollcontroller) {
              return TabbarWidget(verticalcontroller: scrollcontroller);
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            minHeight: MediaQuery.of(context).size.height * 0.55,
            maxHeight: MediaQuery.of(context).size.height * 0.68,
          ),

          // Header Widget
          ValueListenableBuilder(
            valueListenable: userValueNotifier,
            builder: (context, activeUser, _) => Headwidget(
              name: activeUser.name,
              image: activeUser.imagePath,
            ),
          ),
        ],
      ),
    );
  }
}
