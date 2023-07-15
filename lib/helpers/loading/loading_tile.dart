import 'package:flutter/material.dart';

class LoadingTile extends StatelessWidget {
  final bool isincome;
  const LoadingTile({super.key, required this.isincome});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: ListTile(
        leading: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: isincome 
                  ? Colors.green.withAlpha(160)
                  : Colors.red.withAlpha(160),
              shape: BoxShape.circle),
        ),
        title: Container(
          height: 15,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(3)),
        ),
        subtitle: Container(
            height: 10,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2))),
        trailing: Container(
            height: 35,
            width: 60,
            decoration: BoxDecoration(
                color: isincome
                    ? Colors.green.withAlpha(160)
                    : Colors.red.withAlpha(160),
                borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
