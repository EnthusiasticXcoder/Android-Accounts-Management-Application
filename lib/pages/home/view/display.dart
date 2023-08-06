import 'package:flutter/material.dart';

typedef NodeCallback = void Function();

class DisplayMoreDialog extends StatelessWidget {
  final String amount;

  final String catagory, subcatagory, dateTime;
  final Color statusColor;
  final NodeCallback onDelete;

  const DisplayMoreDialog({
    required this.amount,
    required this.dateTime,
    required this.statusColor,
    required this.onDelete,
    super.key,
    required this.catagory,
    required this.subcatagory,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // backbutton
          BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
          // delete button
          IconButton(
              onPressed: () {
                onDelete();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              )),
        ],
      ),
      iconPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // divider
          const Divider(),
          // Catagory label
          ListTile(
              leading: const Text(
                'Catagory :',
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
              trailing: Text(catagory,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ))),
          // Subcatagory label
          ListTile(
            leading: const Text(
              'SubCatagory :',
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
            trailing: Text(
              subcatagory,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // date time label
          ListTile(
            leading: const Text(
              'Date Time :',
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
            trailing: Text(
              dateTime,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black38,
              ),
            ),
          ),
          // Amount Label
          ListTile(
            leading: const Text(
              'Amount :',
              style: TextStyle(
                height: 0,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
              ),
            ),
            trailing: Text(
              amount,
              style: TextStyle(
                height: 0,
                color: statusColor,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      actions: const [],
    );
  }
}
