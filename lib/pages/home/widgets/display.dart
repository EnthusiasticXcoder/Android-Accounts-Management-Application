import 'package:flutter/material.dart';

typedef NodeCallback = void Function();

class DisplayMoreDialog extends StatelessWidget {
  final String amount, dateTime, description;
  final Color statusColor;
  final NodeCallback onDelete;

  const DisplayMoreDialog({
    required this.amount,
    required this.dateTime,
    required this.description,
    required this.statusColor,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
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
      actions: <Widget>[
        TextButton(
            onPressed: () {
              onDelete();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ))
      ],
    );
  }
}
