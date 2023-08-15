import 'package:flutter/foundation.dart' show immutable;
import 'package:my_app/services/services.dart';

@immutable
abstract class MainState {
  const MainState();
}

typedef FilterNodeByIncome = Iterable<DatabaseNode> Function(
    Iterable<DatabaseNode> allNodes, bool isIncome);

typedef GetCatagoryNameById = List<String> Function(
    int catagoryid, int subCatagoryId);

class MainStateHomePage extends MainState {
  final int maxNodeAmount;
  final Iterable<DatabaseNode> allNodes;
  final int sumBalance;
  final int sumIncome;
  final int sumExpense;
  final FilterNodeByIncome filterNodeByIncome;
  final GetCatagoryNameById getCatagoryNameById;
  final List<Filters> allfilters;
  final String? message;
  const MainStateHomePage({
    required this.maxNodeAmount,
    required this.allNodes,
    required this.sumBalance,
    required this.sumIncome,
    required this.sumExpense,
    required this.allfilters,
    required this.filterNodeByIncome,
    required this.getCatagoryNameById,
    this.message,
  });
}

class MainStateCreatedNode extends MainState {
  final bool isIncome;
  const MainStateCreatedNode(this.isIncome);
}

class MainStateDisplayNode extends MainState {
  final int id;
  final String amount;
  final String catagory, subcatagory, dateTime;
  final bool statusColor;

  const MainStateDisplayNode({
    required this.id,
    required this.amount,
    required this.catagory,
    required this.subcatagory,
    required this.dateTime,
    required this.statusColor,
  });
}

class MainStateFilteringNode extends MainState {
  final List<int> yearList;
  final List<int> dateList;
  final List<int> monthList;
  const MainStateFilteringNode({
    required this.yearList,
    required this.dateList,
    required this.monthList,
  });
}
