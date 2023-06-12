import 'package:flutter/material.dart';

class TabbarWidget extends StatefulWidget {
  const TabbarWidget({super.key});

  @override
  State<TabbarWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        // Upper Margin
        const SizedBox(height: 12),
        // Uppwe Nauch of Sliding Pannel
        _uppernauchwidget(context),
        // Bottom Margin of Upper Nauch
        const SizedBox(height: 6),
        // TabBar Tab creation widget
        _tabbar(context),
        // Floation Add Node Button
        Padding(
          padding: const EdgeInsets.only(
            right: 18,
            top: 18,
          ),
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.add_rounded,
              size: 35,
            ),
          ),
        ),
        // TabBar View Widget Associated With Each Tab
        _tabbarview(context),
      ],
    );
  }

  Widget _uppernauchwidget(BuildContext context) => Center(
        child: Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12)),
        ),
      );

  Widget _tabbar(BuildContext context) => TabBar(
        controller: _tabController,
        tabs: const <Widget>[
          Tab(
            text: 'Income',
          ),
          Tab(
            text: 'Expendeture',
          ),
        ],
      );

  Widget _tabbarview(BuildContext context) => Expanded(
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            // Income Tab
            _listtileview(context, _list['Income']!.toList(), 'income'),
            // Expenditure Tab
            _listtileview(context, _list['Expenses']!.toList(), 'expense'),
          ],
        ),
      );

  //Widget _incomewidget(BuildContext context, )

  Widget _listtileview(
      BuildContext context, List<List<String>> listData, status) {
    IconData icon = Icons.arrow_upward_rounded;
    Color color = Colors.red;
    if (status == 'income') {
      icon = Icons.arrow_downward_rounded;
      color = Colors.green;
    }

    return ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, index) {
        String value = listData[index][0];
        String description = listData[index][1];
        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          child: ListTile(
            // Leading Icon
            leading: Icon(
              icon,
              color: color,
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
                color: color,
                fontSize: 22,
              ),
            ),
          ),
        );
      },
    );
  }
}

var _list = {
  'Income': [
    ['200', 'To One', '2/1/24', '2:20'],
    ['400', 'To TWO', '2/1/24', '2:40'],
    ['100', 'To THREE', '3/2/24', '2:10'],
  ],
  'Expenses': [
    ['700', 'To FOUR', '2/1/24', '2:60'],
    ['600', 'To FIVE', '3/1/24', '2:10'],
    ['1000', 'To SIX', '3/1/24', '3:20'],
  ]
};
