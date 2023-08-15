import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/helpers/shaders/light_gradient.dart';
import 'package:my_app/pages/routing/app_routs.dart';
import 'package:my_app/services/services.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:my_app/pages/main/widgets/widgets.dart';

import 'view/views.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final TabController _tabController;

  final List _catagory = [],
      _subcatagory = [],
      _year = [DateTime.now().year],
      _month = [],
      _date = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) async {
        if (state is MainStateCreatedNode) {
          // Create Node Dialog Box
          final isIncome = state.isIncome;
          await showDialog(
            context: context,
            builder: (context) => CreateNewNodeDialog(isIncome: isIncome),
          ).whenComplete(
              () => context.read<MainBloc>().add(const MainEventHideDialog()));
        } else if (state is MainStateFilteringNode) {
          // Filter Nodes Dialog Box
          await showDialog(
            context: context,
            builder: (context) => FilterView(
                dateList: state.dateList,
                monthList: state.monthList,
                yearList: state.yearList,
                catagory: _catagory,
                subcatagory: _subcatagory,
                year: _year,
                month: _month,
                date: _date),
          ).whenComplete(
              () => context.read<MainBloc>().add(const MainEventHideDialog()));
        } else if (state is MainStateDisplayNode) {
          // Display More Dialog
          await showDialog(
            context: context,
            builder: (context) => DisplayMoreDialog(
              id: state.id,
              amount: state.amount,
              dateTime: state.dateTime,
              catagory: state.catagory,
              subcatagory: state.subcatagory,
              statusColor: state.statusColor ? Colors.green : Colors.red,
            ),
          ).whenComplete(
              () => context.read<MainBloc>().add(const MainEventHideDialog()));
        }
      },
      child: CustomPaint(
        painter: LightGradient(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          // Header Widget
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: MediaQuery.of(context).size.height * 0.08,
            backgroundColor: Colors.transparent,
            title: BlocBuilder<NodeBloc, NodeState>(
              builder: (context, state) {
                if (state is NodeStateUserExist) {
                  return Headwidget(
                    name: state.currentUser.name,
                    navigate: () {
                      Navigator.of(context).pushNamed(AppRouts.settingspage);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          // Bottom Sliding Pannel
          body: SlidingUpPanel(
            body: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.025,
                bottom: MediaQuery.of(context).size.height * 0.7,
              ),
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  // linggraph plot
                  PageBox(
                    child: BlocBuilder<MainBloc, MainState>(
                      buildWhen: (previous, current) =>
                          current is MainStateHomePage,
                      builder: (context, state) {
                        if (state is MainStateHomePage) {
                          return Linegraph(
                            maxvalue: state.maxNodeAmount,
                            nodes: state.allNodes,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  // balance Display widget
                  PageBox(
                    child: BlocBuilder<MainBloc, MainState>(
                      buildWhen: (previous, current) =>
                          current is MainStateHomePage,
                      builder: (context, state) {
                        if (state is MainStateHomePage) {
                          return BalanceNotationWidget(
                            balance: state.sumBalance,
                            income: state.sumIncome,
                            expense: state.sumExpense,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),

                  // Bargraph plot
                  PageBox(
                      child: BlocBuilder<MainBloc, MainState>(
                    buildWhen: (previous, current) =>
                        current is MainStateHomePage,
                    builder: (context, state) {
                      if (state is MainStateHomePage) {
                        return BarChart(
                          nodes: state.allNodes,
                        );
                      } else {
                        return Container();
                      }
                    },
                  )),
                ],
              ),
            ),
            panelBuilder: (scrollcontroller) {
              return TabbarWidget(
                tabController: _tabController,
                filter: Filter(
                  onTap: () {
                    // open FIlter Dialog
                    context
                        .read<MainBloc>()
                        .add(const MainEventFilteringNode());
                  },
                  catagory: _catagory,
                  date: _date,
                  month: _month,
                  subcatagory: _subcatagory,
                  year: _year,
                ),
                tabs: const ['Income', 'Expendeture'],
                tabviews: <Widget>[
                  // List of Income Nodes
                  TabListView(isIncome: true, controller: scrollcontroller),
                  // List of Expense Nodes
                  TabListView(isIncome: false, controller: scrollcontroller),
                ],
              );
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            minHeight: MediaQuery.of(context).size.height * 0.5,
            maxHeight: MediaQuery.of(context).size.height * 0.87,
          ),
        ),
      ),
    );
  }
}
