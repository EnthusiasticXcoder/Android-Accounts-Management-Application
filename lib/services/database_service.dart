import 'dart:async';
import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/services/database_exceptions.dart';
import 'package:my_app/services/database_node.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _db;

  List<DatabaseNote> _nodes = [];

  late final StreamController<DatabaseNote> _nodesStreamController;

  static final DatabaseService _service = DatabaseService._sharedInstance();
  DatabaseService._sharedInstance() {
    _nodesStreamController = StreamController<DatabaseNote>.broadcast();
  }
  factory DatabaseService() => _service;

  int get totalIncome {
    if (_nodes.isNotEmpty) {
      final nodes = _nodes.where((node) => node.isincome);
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

  int get totalExpense {
    if (_nodes.isNotEmpty) {
      final nodes = _nodes.where((node) => !node.isincome);
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

  int get balance {
    if (_nodes.isNotEmpty) {
      return _nodes
          .map((node) => (node.isincome) ? node.amount : node.amount * (-1))
          .reduce((value, element) => value + element);
    } else {
      return 0;
    }
  }

  int get getmaxnode {
    if (_nodes.isNotEmpty) {
      return _nodes
          .reduce(
              (max, element) => (max.amount > element.amount) ? max : element)
          .amount;
    } else {
      return 0;
    }
  }

  List<DatabaseNote> get allNodes => _nodes;

  List<DatabaseNote> getNodes(DateTime? filter, value) {
    if (filter == null) {
      return _nodes.reversed.where((node) => node.isincome == value).toList();
    } else {
      return _nodes
          .where((node) =>
              node.isincome == value &&
              node.date >= filter.day &&
              node.month == filter.month &&
              node.year == filter.year)
          .toList();
    }
  }

  Stream<DatabaseNote> getstream() => _nodesStreamController.stream;

  Future<void> createNode({
    required int amount,
    required String description,
    required int isIncome,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    DateTime now = DateTime.now();

    final values = {
      amountcolumn: amount,
      descridecolumn: description,
      daycolumn: (now.day).toInt(),
      monthcolumn: (now.month).toInt(),
      yearcolumn: (now.year).toInt(),
      hourcolumn: (now.hour).toInt(),
      minutescolumn: (now.minute).toInt(),
      isIncomecolumn: isIncome,
    };
    // adding nodes to local buffer
    final node = DatabaseNote.fromRow(values);
    _nodes.add(node);
    _nodesStreamController.add(node);
    // inserting nodes to database
    await db.insert(tableName, values);
  }

  Future<void> _catchallNodes() async {
    _nodes = await _getallNodes();
    _nodesStreamController.add(_nodes[0]);
  }

  Future<List<DatabaseNote>> _getallNodes() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final nodes = await db.query(tableName);
    return nodes.map((map) => DatabaseNote.fromRow(map)).toList();
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      return db;
    }
  }

  Future<void> _ensureDbIsOpen() async {
    try {
      await open();
    } on DatabaseAlreadyOpenException {
      // empty
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db != null) {
      await db.close();
      _db = null;
    } else {
      throw DatabaseIsNotOpen();
    }
  }

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      // create the user table
      await db.execute(createTable);
      // Setting Values
      await _catchallNodes();
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}
