import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/crud_constants.dart';

import 'package:my_app/services/database_service.dart';
import 'package:my_app/utilities/controllers/state_controller.dart';

class BalanceNotationWidget extends StatefulWidget {
  const BalanceNotationWidget({super.key});

  @override
  State<BalanceNotationWidget> createState() => _BalanceNotationWidgetState();
}

class _BalanceNotationWidgetState extends State<BalanceNotationWidget> {
  late final DatabaseService _databaseService;

  @override
  void initState() {
    _databaseService = DatabaseService();
    StateController().addStateFunction(setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Upper Margin
        const SizedBox(),
        // Total Income and expense widgets
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Income Indecator
            _balanceCard(
              context,
              amount: _databaseService.gettotalIncome,
              icon: Icons.arrow_downward_rounded,
              color: Colors.green,
            ),

            // Expense Indecator
            _balanceCard(
              context,
              amount: _databaseService.getTotalExpense,
              icon: Icons.arrow_upward_rounded,
              color: Colors.red,
            ),
          ],
        ),
        // Balance Field
        AnimatedDigitWidget(
          prefix: '₹',
          value: _databaseService.getBalance,
          enableSeparator: true,
          textStyle: TextStyle(
            color: _databaseService.diffColor,
            fontSize: 76,
            fontWeight: FontWeight.bold,
            height: 0,
          ),
        ),

        // Balance Notation
        Text(
          totalBalance,
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
          style: TextStyle(
            color: Colors.blueGrey.shade100,
            fontSize: 18,
          ),
        ),

        // Lower Margin
        const SizedBox(height: 300),
      ],
    );
  }

  Widget _balanceCard(BuildContext context,
          {required int amount,
          required IconData icon,
          required Color color}) =>
      Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: color,
              ),
              // margin
              const SizedBox(width: 2),
              AnimatedDigitWidget(
                  prefix: '₹',
                  value: amount,
                  textStyle: TextStyle(color: color, height: 0)),
            ],
          ),
        ),
      );
}
