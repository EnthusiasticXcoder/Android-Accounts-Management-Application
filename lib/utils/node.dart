import 'package:flutter/widgets.dart' show ValueNotifier;
import 'package:my_app/services/services.dart';

ValueNotifier<Iterable<DatabaseNode>> get nodeValueNotifier {
  // Get Node Value Notifier
  final service = DatabaseService();
  return service.nodeValueLisnable;
}

int get maxNodeAmount {
  // Get The Amount Of DatabaseNode Which Has Maximum Amount Value
  final service = DatabaseService();
  return service.maxNodeAmount;
}

int get sumIncome {
  // Get The Sum of Amounts Of all Income Node
  final service = DatabaseService();
  return service.sumIncome;
}

int get sumExpense {
  // Get The Sum of Amounts Of all Expense Node
  final service = DatabaseService();
  return service.sumExpense;
}

int get sumBalance {
  // Get The Sum of Amounts Of all Nodes with +vs income and -vs expense
  final service = DatabaseService();
  return service.sumBalance;
}

List<int> get monthList {
  // List of All the month value in node database
  final service = DatabaseService();
  return service.getMonths;
}

List<int> get yearList {
  // List of All the year value in node database
  final service = DatabaseService();
  return service.getYears;
}

List<int> get dateList {
  // List of All the dates value in node database
  final service = DatabaseService();
  return service.getDates;
}

void filterNodes(FilterBy? filter) {
  // Get All The Nodes And Filter Them According To the parameters
  final service = DatabaseService();
  service.filterNodes(filter);
}

Iterable<DatabaseNode> filterNodesByIncome(
    Iterable<DatabaseNode>? nodes, bool isIncome) {
  // Get All The Nodes And Filter Them According To income
  final service = DatabaseService();
  return service.filterNodesByIncome(nodes, isIncome);
}

Future<void> createNode({
  required int amount,
  required int catagoryId,
  required int subCatagoryId,
  required int isIncome,
}) async {
  // Create a New Node
  final service = DatabaseService();
  service.createNode(
      amount: amount,
      catagoryId: catagoryId,
      subCatagoryId: subCatagoryId,
      isIncome: isIncome);
}

Future<void> deleteNode(DatabaseNode node) async {
  // Delete a Node with node object
  final service = DatabaseService();
  service.deleteNode(node);
}
