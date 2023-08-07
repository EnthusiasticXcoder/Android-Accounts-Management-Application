import 'package:flutter/material.dart';

import 'package:my_app/pages/home/widgets/node_tile.dart';
import 'package:my_app/utils/utils.dart';

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
      builder: (context, nodes, _) {
        nodes = filterNodesByIncome(nodes, isIncome);
        return ListView.builder(
          controller: controller,
          itemCount: nodes.length,
          itemBuilder: (context, index) {
            final node = nodes.elementAt(index);

            final names = getCatagoryNameById(
                catagoryId: node.catogary, subCatagoryId: node.subCatagory);
            String dateTime =
                '${node.date}/${node.month}/${node.year} \t ${node.hour}:${node.minutes}';

            return NodeTile(
                isIncome: isIncome,
                catagory: names.first,
                subcatagory: names.last,
                dateTime: dateTime,
                amount: node.amount,
                onDelete: () async {
                  try {
                    await deleteNode(node);
                  } on UnableToDeleteException {
                    // message to display
                  }
                });
          },
        );
      },
    );
  }
}
