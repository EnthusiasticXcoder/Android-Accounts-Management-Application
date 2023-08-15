import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/services/services.dart';


typedef NodeCallback = void Function();

class NodeTile extends StatelessWidget {
  final int id;
  final bool isIncome;
  final String catagory, subcatagory, dateTime;
  final int amount;

  const NodeTile({
    super.key,
    required this.id,
    required this.isIncome,
    required this.dateTime,
    required this.amount,
    required this.catagory,
    required this.subcatagory,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: ListTile(
        // Leading Icon
        leading: Icon(
          isIncome ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
          color: isIncome ? Colors.green : Colors.red,
          size: 35,
        ),

        // Description
        title: Text(
          'Catagory : $catagory\nSubCatagory : $subcatagory',
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),

        // Date and Time
        subtitle: Text(
          dateTime,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
        // Value Amount
        trailing: Text(
          '₹$amount',
          style: TextStyle(
            color: isIncome ? Colors.green : Colors.red,
            fontSize: 22,
          ),
        ),

        // Discription overview
        onLongPress: () {
          // open discription dailog
          context.read<MainBloc>().add(MainEventDisplayNode(
                id: id,
                amount: amount.toString(),
                catagory: catagory,
                subcatagory: subcatagory,
                dateTime: dateTime,
                statusColor: isIncome,
              ),);
        },
      ),
    );
  }
}
