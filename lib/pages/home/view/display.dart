import 'package:flutter/material.dart';

class DisplayMoreDialog extends StatelessWidget {
  final String amount, dateTime, description;
  final Color statusColor;

  const DisplayMoreDialog(
      {required this.amount,
      required this.dateTime,
      required this.description,
      required this.statusColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
                size: 27,
              )),
          const SizedBox(),
        ],
      ),
      iconPadding: const EdgeInsets.only(top: 3.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            amount,
            style: TextStyle(
              color: statusColor,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            dateTime,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
            ),
          ),
        ],
      ),
      content: Text(
        description,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 15,
        ),
      ),
    );
  }
}
