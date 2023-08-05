import 'package:sqflite/sqflite.dart';

import '../../constants/crud_constants.dart';
import '../database_exceptions.dart';
import 'database_node.dart';

class NodeService {
  static final NodeService _service = NodeService._sharedInstance();
  NodeService._sharedInstance();
  factory NodeService() => _service;

  Iterable<DatabaseNode> _nodes = [];

  int getMaxAmount(List<DatabaseNode> nodes) {
    if (nodes.isNotEmpty) {
      return nodes
          .reduce(
              (max, element) => (max.amount > element.amount) ? max : element)
          .amount;
    } else {
      return 0;
    }
  }

  int totalIncome(Iterable<DatabaseNode> nodes) {
    if (nodes.isNotEmpty) {
      nodes = nodes.where((node) => node.isincome);
      if (nodes.isNotEmpty) {
        return nodes
            .map((node) => node.amount)
            .reduce((value, element) => value + element);
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  int totalExpense(Iterable<DatabaseNode> nodes) {
    if (nodes.isNotEmpty) {
      nodes = nodes.where((node) => !node.isincome);
      if (nodes.isNotEmpty) {
        return nodes
            .map((node) => node.amount)
            .reduce((value, element) => value + element);
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  int balance(List<DatabaseNode> nodes) {
    if (nodes.isNotEmpty) {
      return nodes
          .map((node) => (node.isincome) ? node.amount : node.amount * (-1))
          .reduce((value, element) => value + element);
    } else {
      return 0;
    }
  }

  List<DatabaseNode> filterNodes(List<DatabaseNode> nodes ,DateTime? filter, value){
    if (filter == null) {
      return nodes.reversed.where((node) => node.isincome == value).toList();
    } else {
      return nodes
          .where((node) =>
              node.isincome == value &&
              node.date >= filter.day &&
              node.month == filter.month &&
              node.year == filter.year)
          .toList();
    }
  }

  Future<void> createNode({
    required Database db,
    required int amount,
    required int catagoryId,
    required int subCatagoryId,
    required int isIncome,
  }) async {
    DateTime now = DateTime.now();

    final values = {
      amountcolumn: amount,
      catagoryIdcolumn: catagoryId,
      subcatagoryIdcolumn: subCatagoryId,
      datecolumn: (now.day).toInt(),
      monthcolumn: (now.month).toInt(),
      yearcolumn: (now.year).toInt(),
      hourcolumn: (now.hour).toInt(),
      minutescolumn: (now.minute).toInt(),
      isIncomecolumn: isIncome,
    };
    // inserting nodes to database
    final id = await db.insert(nodetable, values);
    values.addAll({idcolumn: id});
    // update local nodes
    _nodes.followedBy([DatabaseNode.fromRow(values)]);
  }

  Future<void> deleteNode(
      {required Database db, required DatabaseNode node}) async {
    final numberofdelete = await db.delete(
      nodetable,
      where: '$idcolumn = ? ',
      whereArgs: [node.id],
    );

    if (numberofdelete != 1) {
      throw UnableToDeleteException();
    } else {
      _nodes.where((element) => element.id != node.id);
    }
  }

  Future<void> loadNodes({required Database db, required int userId}) async {
    _nodes = await getallNodes(db: db, userId: userId);
  }

  Future<Iterable<DatabaseNode>> getallNodes(
      {required Database db, required int userId}) async {
    final nodes = await db
        .query(nodetable, where: '$userIdcolumn = ?', whereArgs: [userId]);
    return nodes.map((map) => DatabaseNode.fromRow(map));
  }
}
