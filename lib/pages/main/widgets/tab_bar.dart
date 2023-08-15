import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/services/services.dart';

class TabbarWidget extends StatelessWidget {
  final List<String> tabs;
  final List<Widget> tabviews;
  final Widget filter;
  final TabController tabController;

  const TabbarWidget({
    super.key,
    required this.tabs,
    required this.tabviews,
    required this.tabController,
    required this.filter,
  });
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        // Upper Margin
        SizedBox(height: height * 0.02),

        // Upper Nauch of Sliding Pannel
        _uppernauchwidget(context),

        // Bottom Margin of Upper Nauch
        SizedBox(height: height * 0.01),

        // TabBar Tab creation widget
        TabBar(
          controller: tabController,
          tabs: tabs
              .map((tab) => Tab(
                    text: tab,
                  ))
              .toList(),
        ),

        // Filter Add Node Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // filter nodes
            filter,
            // button to add node
            _floatingActionButton(context, height * 0.02),
          ],
        ),
        SizedBox(height: height * 0.01),
        // TabBar View Widget Associated With Each Tab
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: tabviews,
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

  Widget _floatingActionButton(BuildContext context, double height) => Padding(
        padding: EdgeInsets.only(
          right: height,
          top: height,
          bottom: height * 0.5,
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Create Node Widget
            final isIncome = (tabController.index == 0) ? true : false;
            context.read<MainBloc>().add(
                  MainEventCreateingNode(isIncome),
                );
          },
          child: const Icon(
            Icons.add_rounded,
            size: 35,
          ),
        ),
      );
}
