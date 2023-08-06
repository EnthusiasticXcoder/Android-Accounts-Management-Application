import 'package:my_app/services/filter/database_filter.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/crud_constants.dart';
import '../database_exceptions.dart';
import 'database_node.dart';

class NodeService {
  static final NodeService _service = NodeService._sharedInstance();
  NodeService._sharedInstance();
  factory NodeService() => _service;

  Iterable<DatabaseNode> _nodes = [];

  List<int> getdates = [], getmonths = [], getyears = [];

  int getMaxAmount(Iterable<DatabaseNode> nodes) {
    if (nodes.isNotEmpty) {
      return nodes
          .reduce(
              (max, element) => (max.amount > element.amount) ? max : element)
          .amount;
    } else {
      return 0;
    }
  }

  Iterable<DatabaseNode> get allNodes => _nodes;

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

  int balance(Iterable<DatabaseNode> nodes) {
    if (nodes.isNotEmpty) {
      return nodes
          .map((node) => (node.isincome) ? node.amount : node.amount * (-1))
          .reduce((value, element) => value + element);
    } else {
      return 0;
    }
  }

  Iterable<DatabaseNode> filterNodes(
      {Iterable<DatabaseNode>? nodes, bool? isIncome, FilterBy? filter}) {
    nodes = (nodes == null) ? _nodes : nodes;
    if (filter == null) {
      return nodes.toList().reversed.where((node) => node.isincome == isIncome);
    } else {
      return nodes.where((node) => node.cheackFilter(filter));
    }
  }

  Future<void> createNode({
    required Database db,
    required int userId,
    required int amount,
    required int catagoryId,
    required int subCatagoryId,
    required int isIncome,
  }) async {
    DateTime now = DateTime.now();

    final values = {
      amountcolumn: amount,
      userIdcolumn: userId,
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
    _nodes = _nodes.followedBy([DatabaseNode.fromRow(values)]);
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
      _nodes = _nodes.where((element) => element.id != node.id);
    }
  }

  Future<void> loadNodes({required Database db, required int userId}) async {
    _nodes = await getallNodes(db: db, userId: userId);
    await getDates(db);
  }

  Future<void> getDates(Database db) async {
    final datetime = DateTime.now();
    // get date
    await db
        .query(nodetable, distinct: true, columns: [datecolumn]).then((value) {
      final dates = value.map((element) => element.values.first as int);
      final date = dates.firstWhere(
        (dat) => dat == datetime.day,
        orElse: () => -1,
      );
      if (date == -1) {
        getdates = dates.followedBy([datetime.day]).toList();
      } else {
        getdates = dates.toList();
      }
    });
    // get month
    await db
        .query(nodetable, distinct: true, columns: [monthcolumn]).then((value) {
      final months = value.map((element) => element.values.first as int);
      final month = months.firstWhere(
        (mont) => mont == datetime.month,
        orElse: () => -1,
      );
      if (month == -1) {
        getmonths = months.followedBy([datetime.month]).toList();
      } else {
        getmonths = months.toList();
      }
    });
    // get year
    await db
        .query(nodetable, distinct: true, columns: [yearcolumn]).then((value) {
      final years = value.map((element) => element.values.first as int);
      final year = years.firstWhere(
        (yer) => yer == datetime.year,
        orElse: () => -1,
      );
      if (year == -1) {
        getyears = years.followedBy([datetime.year]).toList();
      } else {
        getyears = years.toList();
      }
    });
  }

  Future<Iterable<DatabaseNode>> getallNodes(
      {required Database db, required int userId}) async {
    final nodes = await db
        .query(nodetable, where: '$userIdcolumn = ?', whereArgs: [userId]);
    return nodes.map((map) => DatabaseNode.fromRow(map));
  }
}
