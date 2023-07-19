import 'package:flutter/material.dart';

import 'package:my_app/pages/home/view/display.dart';
import 'package:my_app/helpers/loading/loading_tile.dart';
import 'package:my_app/services/database_exceptions.dart';

import 'package:my_app/services/database_service.dart';

part 'tab_list.dart';
part 'node_tile.dart';
part '../view/create_node.dart';

class TabbarWidget extends StatefulWidget {
  const TabbarWidget({super.key, required this.verticalcontroller});
  final ScrollController verticalcontroller;

  @override
  State<TabbarWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  DateTime? _filter;

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
            // filtur by date
            _filterwidget(context),
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
                filter: _filter,
                isIncome: true,
                controller: widget.verticalcontroller,
              ),
              // Expenditure Tab
              TabListView(
                filter: _filter,
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

  Widget _filterwidget(BuildContext context) => InkWell(
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: (_filter == null) ? DateTime.now() : _filter!,
            firstDate: DateTime(2023),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            setState(() {
              _filter = date;
            });
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 15.0),
          width: 200.0,
          decoration: BoxDecoration(
            color: const Color.fromARGB(129, 227, 242, 253),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: -1.0,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // margin
              const SizedBox(),
              // textfield to show filter
              Text(
                (_filter == null)
                    ? 'No Filter'
                    : 'Date : ${_filter!.day}/${_filter!.month}/${_filter!.year}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              // clear filter button
              IconButton(
                  onPressed: () {
                    setState(() {
                      _filter = null;
                    });
                  },
                  icon: Icon(
                    Icons.filter_alt_off_rounded,
                    color: Colors.blue.shade500,
                  )),
            ],
          ),
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
