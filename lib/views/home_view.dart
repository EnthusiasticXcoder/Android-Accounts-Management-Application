import 'package:flutter/material.dart';
import 'package:my_app/generics/get_argument.dart';
import 'package:my_app/views/widgets/tab_bar_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key});

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  late int balance;
  Color color = Colors.green;

  @override
  Widget build(BuildContext context) {
    balance = _bal;
    if (_bal > 0) {
      color =const Color.fromARGB(255, 41, 237, 48);
    } else {
      color = Colors.red.shade400;
    }
    return Scaffold(
        backgroundColor: Colors.blue.shade500,
        body: Stack(
          children: <Widget>[
            // Header Widget
            _headerwidget(context),
            // Bottom Sliding Pannel
            _scrollupwidget(context),
          ],
        ));
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

  Widget _scrollupwidget(BuildContext context) {
    setState(() {});
    return SlidingUpPanel(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Upper Margin
          const SizedBox(),
          // Balance Field
          Text(
            '₹ $balance',
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: false,
            ),
            style: TextStyle(
              color: color,
              fontSize: 76,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Balance Notation
          const Text(
            TOTALBALANCE,
            textHeightBehavior: TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: false,
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          // Lower Margin
          const SizedBox(height: 350),
        ],
      ),
      parallaxEnabled: true,
      parallaxOffset: 0.75,
      panelBuilder: (sc) => const TabbarWidget(),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      minHeight: context.getminheight(),
      maxHeight: context.getmaxheight(),
    );
  }
}

var _bal = 2400;
const TOTALBALANCE = 'TOTAL BALANCE';
