import 'package:flutter/material.dart';
import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/helpers/loading/loading_tile.dart';

import 'package:my_app/services/database_service.dart';
import 'package:my_app/utilities/controllers/vertical_controller.dart';
import 'package:my_app/views/dialoges/display_more_dialog.dart';

class TabListView extends StatelessWidget {
  final int status;

  const TabListView({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseService().getNodes(status),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final listData = snapshot.data as List<Map<String, Object?>>;
              return ListView.builder(
                controller: VerticalController().getcontroller,
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  int value = listData[index][amountcolumn] as int;
                  String description =
                      listData[index][descridecolumn] as String;
                  String dateTime =
                      '${listData[index][daycolumn]}/${listData[index][monthcolumn]}/${listData[index][yearcolumn]}\t${listData[index][hourcolumn]}:${listData[index][minutescolumn]}'
                      '';
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: ListTile(
                      // Leading Icon
                      leading: Icon(
                        status == 1
                            ? Icons.arrow_downward_rounded
                            : Icons.arrow_upward_rounded,
                        color: status == 1 ? Colors.green : Colors.red,
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
                        '₹$value',
                        style: TextStyle(
                          color: status == 1 ? Colors.green : Colors.red,
                          fontSize: 22,
                        ),
                      ),

                      // Discription overview
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => DisplayMoreDialog(
                            amount: value.toString(),
                            dateTime: dateTime,
                            description: description,
                            statusColor:
                                (status == 1) ? Colors.green : Colors.red,
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            default:
              return ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => LoadingTile(status: status));
          }
        },
    );
  }
}
