import 'package:flutter/material.dart';

import 'package:my_app/services/database_service.dart';
import 'package:my_app/utilities/get_state.dart';

class BalanceNotationWidget extends StatefulWidget {
  const BalanceNotationWidget({super.key});

  @override
  State<BalanceNotationWidget> createState() => _BalanceNotationWidgetState();
}

class _BalanceNotationWidgetState extends State<BalanceNotationWidget> {
  @override
  Widget build(BuildContext context) {
    var balance = DatabaseService().getBalance;
    int amount = balance[0];
    var color = balance[1];
    BalanceState().setFunction(setState);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Upper Margin
        const SizedBox(),

        // Balance Field
        Text(
          '₹ $amount',
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
          totalBalance,
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
    );
  }
}

const totalBalance = 'TOTAL BALANCE';
