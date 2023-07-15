import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/services/database_exceptions.dart';
import 'package:my_app/services/database_node.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _db;

  int _totalIncome = 0, _totalExpense = 0;

  List<DatabaseNote> _nodes = [];

  late final StreamController<DatabaseNote> _nodesStreamController;

  static final DatabaseService _service = DatabaseService._sharedInstance();
  DatabaseService._sharedInstance() {
    _nodesStreamController = StreamController<DatabaseNote>.broadcast();
  }
  factory DatabaseService() => _service;

  int get gettotalIncome => _totalIncome;

  int get getTotalExpense => _totalExpense;

  int get getBalance => (_totalIncome >= _totalExpense)
      ? (_totalIncome - _totalExpense)
      : (_totalExpense - _totalIncome);

  Color get diffColor =>
      (_totalIncome >= _totalExpense) ? Colors.greenAccent : Colors.red;

  List<DatabaseNote> getNodes(column, value) =>
      _nodes.where((node) => node.isincome == value).toList();

  Stream<DatabaseNote> getstream() => _nodesStreamController.stream;

  Future<List<int>> _getTotalIncomeExpense() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final result = await db.query(
      tableName,
      columns: ['Sum($amountcolumn) as $amountcolumn', statuscolumn],
      groupBy: statuscolumn,
    );

    switch (result.length) {
      case (0):
        return [0, 0];
      case (1):
        if ((result[0][statuscolumn] as int) == 0) {
          return [0, result[0][amountcolumn] as int];
        } else {
          return [result[0][amountcolumn] as int, 0];
        }
      case (2):
        return [result[1][amountcolumn] as int, result[0][amountcolumn] as int];
    }
    return [0, 0];
  }

  Future<void> createExpenseNode({
    required amount,
    required description,
  }) async =>
      await _createNode(amount, description, 0);

  Future<void> createIncomeNode({
    required amount,
    required description,
  }) async =>
      await _createNode(amount, description, 1);

  Future<void> _createNode(
    int amount,
    String description,
    int status,
  ) async {
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
      statuscolumn: status,
    };
    if (status == 0) {
      _totalExpense += amount;
    } else {
      _totalIncome += amount;
    }
    // adding nodes to local buffer
    final node = DatabaseNote.fromRow(values);
    _nodes.add(node);
    _nodesStreamController.add(node);
    // inserting nodes to database
    await db.insert(tableName, values);
  }

  Future<void> _setvariables() async {
    final totalsum = await _getTotalIncomeExpense();
    _totalIncome = totalsum[0];
    _totalExpense = totalsum[1];
    _nodes = await getallNodes();
    _nodesStreamController.add(_nodes[0]);
  }

  Future<List<DatabaseNote>> getallNodes() async {
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
      await _setvariables();
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}
