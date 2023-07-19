import 'package:flutter/material.dart';
import 'package:animated_digit/animated_digit.dart';
import 'package:my_app/constants/crud_constants.dart';

class BalanceNotationWidget extends StatelessWidget {
  final int income, expense, balance;

  const BalanceNotationWidget(
      {super.key,
      required this.income,
      required this.expense,
      required this.balance});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        // Total Income and expense widgets
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Income Indecator
            _balanceCard(
              context,
              amount: income,
              icon: Icons.arrow_downward_rounded,
              color: Colors.green,
            ),

            // Expense Indecator
            _balanceCard(
              context,
              amount: expense,
              icon: Icons.arrow_upward_rounded,
              color: Colors.red,
            ),
          ],
        ),
        // Balance Field
        AnimatedDigitWidget(
          prefix: '₹',
          value: (income > expense) ? balance : balance * (-1),
          enableSeparator: true,
          valueColors: [
            ValueColor(
              condition: () => balance < 0,
              color: Colors.red,
            ),
            ValueColor(
              condition: () => balance >= 0,
              color: Colors.green,
            )
          ],
          textStyle: TextStyle(
            color: Colors.green.shade800,
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

        const SizedBox(height: 8.0),
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
