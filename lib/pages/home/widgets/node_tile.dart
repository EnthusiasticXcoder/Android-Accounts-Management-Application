part of 'tab_bar.dart';


typedef NodeCallback = void Function();

class NodeTile extends StatelessWidget {
  final bool isIncome;
  final String description;
  final String dateTime;
  final int amount;
  final NodeCallback onDelete;

  const NodeTile({
    super.key,
    required this.isIncome,
    required this.description,
    required this.dateTime,
    required this.amount, required this.onDelete,
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
          description,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 18,
            fontWeight: FontWeight.w500,
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
          showDialog(
            context: context,
            builder: (context) => DisplayMoreDialog(
              amount: amount.toString(),
              dateTime: dateTime,
              description: description,
              statusColor: isIncome ? Colors.green : Colors.red,
              onDelete: onDelete,
            ),
          );
        },
      ),
    );
  }
}
