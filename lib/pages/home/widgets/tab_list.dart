part of 'tab_bar.dart';

class TabListView extends StatelessWidget {
  final bool isIncome;
  final DateTime? filter;
  late final DatabaseService _service;

  TabListView({
    super.key,
    required this.isIncome,
    required this.filter,
  }) {
    _service = DatabaseService();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _service.getstream(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            final nodes = _service.getNodes(filter, isIncome);
            return ListView.builder(
              controller: VerticalController().getcontroller,
              itemCount: nodes.length,
              itemBuilder: (context, index) {
                final node = nodes.elementAt(index);
                int amount = node.amount;
                String description = node.description;
                String dateTime =
                    '${node.date}/${node.month}/${node.year} \t ${node.hour}:${node.minutes}';

                return NodeTile(
                  isIncome: isIncome,
                  description: description,
                  dateTime: dateTime,
                  amount: amount,
                );
              },
            );

          default:
            return ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) =>
                    LoadingTile(isincome: isIncome));
        }
      },
    );
  }
}
