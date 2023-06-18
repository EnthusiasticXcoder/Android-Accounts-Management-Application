import 'package:flutter/material.dart';

import 'package:my_app/services/database_service.dart';
import 'package:my_app/utilities/vertical_controller.dart';


typedef FutureListFunction = Future<List<Map<String, Object?>>> Function();

class TabListView extends StatelessWidget {
  final int status;
  final FutureListFunction getListFunction;

  const TabListView({
    super.key,
    required this.status,
    required this.getListFunction,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getListFunction(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final listData = snapshot.data as List<Map<String, Object?>>;
            return ListView.builder(
              controller: VerticalController().getcontroller,
              itemCount: listData.length,
              itemBuilder: (context, index) {
                int value = listData[index][amountcolumn] as int;
                String description = listData[index][descridecolumn] as String;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: ListTile(
                    // Leading Icon
                    leading: Icon(
                      status == 1 ? incomeIcon : expenseIcon,
                      color: status == 1 ? incomeColor : expenseColor,
                      size: 35,
                    ),

                    // Description
                    title: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // Date and Time
                    subtitle: Text(
                      description,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    // Value Amount
                    trailing: Text(
                      '₹$value',
                      style: TextStyle(
                        color: status == 1 ? incomeColor : expenseColor,
                        fontSize: 22,
                      ),
                    ),
                  ),
                );
              },
            );
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}


const incomeIcon = Icons.arrow_downward_rounded;
const expenseIcon = Icons.arrow_upward_rounded;
const incomeColor = Colors.green;
const expenseColor = Colors.red;