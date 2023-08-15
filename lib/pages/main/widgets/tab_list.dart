import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app/pages/main/widgets/node_tile.dart';
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
    return BlocBuilder<MainBloc, MainState>(
      buildWhen: (previous, current) => current is MainStateHomePage,
      builder: (context, state) {
        if (state is MainStateHomePage) {
          final nodes = state.filterNodeByIncome(state.allNodes, isIncome);
          return ListView.builder(
            controller: controller,
            itemCount: nodes.length,
            itemBuilder: (context, index) {
              final node = nodes.elementAt(index);
              final names =
                  state.getCatagoryNameById(node.catogary, node.subCatagory);
              String dateTime =
                  '${node.date}/${node.month}/${node.year} \t ${node.hour}:${node.minutes}';

              return NodeTile(
                id: node.id,
                isIncome: isIncome,
                catagory: names.first,
                subcatagory: names.last,
                dateTime: dateTime,
                amount: node.amount,
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
