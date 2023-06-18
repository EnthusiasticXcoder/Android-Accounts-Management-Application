import 'package:flutter/material.dart';

import 'package:my_app/services/database_service.dart';

import 'package:my_app/views/widgets/tab_list_view_widget.dart';
import 'package:my_app/utilities/get_state.dart';

class TabbarWidget extends StatefulWidget {
  const TabbarWidget({super.key});

  @override
  State<TabbarWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final DatabaseService _databaseService;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _databaseService = DatabaseService();
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

        // Floation Add Node Button
        Padding(
          padding: const EdgeInsets.only(
            right: 18,
            top: 18,
            bottom: 12,
          ),
          child: FloatingActionButton(
            onPressed: () {
              if (_tabController.index == 0) {
                _databaseService.createIncomeNode(
                    amount: 200, description: 'To ONE');
              } else if (_tabController.index == 1) {
                _databaseService.createExpenseNode(
                    amount: 200, description: 'TO Two');
              }
              //_databaseService.delete();
              setState(() {});
              BalanceState().getState(() {});
            },
            child: const Icon(
              Icons.add_rounded,
              size: 35,
            ),
          ),
        ),

        // TabBar View Widget Associated With Each Tab
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              // Income Tab
              TabListView(
                getListFunction: _databaseService.getIncome,
                status: 1,
              ),
              // Expenditure Tab
              TabListView(
                getListFunction: _databaseService.getExpenses,
                status: 0,
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
}
