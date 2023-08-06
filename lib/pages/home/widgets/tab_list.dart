import 'package:flutter/material.dart';
import 'package:my_app/pages/home/widgets/node_tile.dart';
import 'package:my_app/services/services.dart';

class TabListView extends StatelessWidget {
  final bool isIncome;
  final ScrollController controller;

  const TabListView({
    super.key,
    required this.isIncome,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: nodeValueNotifier,
      builder: (context, nodes, child) {
        return ListView.builder(
          controller: controller,
          itemCount: nodes.length,
          itemBuilder: (context, index) {
            final node = nodes.elementAt(index);
            int amount = node.amount;
            String description = '${node.catogary} > ${node.subCatagory}';
            String dateTime =
                '${node.date}/${node.month}/${node.year} \t ${node.hour}:${node.minutes}';

            return NodeTile(
                isIncome: isIncome,
                description: description,
                dateTime: dateTime,
                amount: amount,
                onDelete: () async {
                  // try {
                  // await _service.deleteNode(node);
                  // } on UnableToDeleteException {
                  // message to display
                });
          },
        );
      },
    );
  }
}
