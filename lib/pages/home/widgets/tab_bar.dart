import 'package:flutter/material.dart';
import 'package:my_app/utilities/controllers/state_controller.dart';

import 'package:my_app/pages/home/view/display.dart';
import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/helpers/loading/loading_tile.dart';

import 'package:my_app/services/database_service.dart';
import 'package:my_app/utilities/controllers/vertical_controller.dart';

part 'tab_list.dart';
part 'node_tile.dart';
part '../view/expense.dart';
part '../view/income.dart';


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

        // Floation Add Node Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () => setState(() {}),
            ),
            FloatingActionButton(
              onPressed: () => setState(() {}),
            ),
            _floatingActionButton(context),
          ],
        ),

        // TabBar View Widget Associated With Each Tab
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              // Income Tab
              TabListView(isIncome: true),
              // Expenditure Tab
              TabListView(isIncome: false),
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
            if (_tabController.index == 0) {
              showDialog(
                context: context,
                builder: (context) => const CreateIncomeDialog(),
              );
            } else if (_tabController.index == 1) {
              showDialog(
                context: context,
                builder: (context) => const CreateExpenseDialog(),
              );
            }
          },
          child: const Icon(
            Icons.add_rounded,
            size: 35,
          ),
        ),
      );
}
