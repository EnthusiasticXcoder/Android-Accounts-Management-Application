import 'package:flutter/material.dart';
import 'package:my_app/pages/home/view/create_node.dart';
import 'package:my_app/pages/home/widgets/widgets.dart';

class TabbarWidget extends StatefulWidget {
  final ScrollController verticalcontroller;

  const TabbarWidget({super.key, required this.verticalcontroller});

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

        // Upper Nauch of Sliding Pannel
        _uppernauchwidget(context),

        // Bottom Margin of Upper Nauch
        const SizedBox(height: 6),

        // TabBar Tab creation widget
        TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expendeture',
            ),
          ],
        ),

        // Filter Add Node Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // filter nodes
            Filter(),
            // button to add node
            _floatingActionButton(context),
          ],
        ),

        // TabBar View Widget Associated With Each Tab
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              // Income Tab
              TabListView(
                isIncome: true,
                controller: widget.verticalcontroller,
              ),
              // Expenditure Tab
              TabListView(
                isIncome: false,
                controller: widget.verticalcontroller,
              ),
            ],
          ),
        ),
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

  Widget _floatingActionButton(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          right: 18,
          top: 18,
          bottom: 12,
        ),
        child: FloatingActionButton(
          onPressed: () {
            final isIncome = (_tabController.index == 0) ? true : false;
            showDialog(
              context: context,
              builder: (context) => CreateNewNodeDialog(isIncome: isIncome),
            );
          },
          child: const Icon(
            Icons.add_rounded,
            size: 35,
          ),
        ),
      );
}
