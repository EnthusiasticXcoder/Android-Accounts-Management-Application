import 'package:flutter/foundation.dart';
import 'package:my_app/services/services.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/services/database_exceptions.dart';

import 'package:my_app/services/filter/filter_service.dart';
import 'package:my_app/services/user/user_service.dart';
import 'package:my_app/services/node/node_service.dart';

/*class AatabaseService {
  Database? _db;

  List<DatabaseNode> _nodes = [];

  late final StreamController<DatabaseNode> _nodesStreamController;

  static final DatabaseService _service = DatabaseService._sharedInstance();
  DatabaseService._sharedInstance() {
    _nodesStreamController = StreamController<DatabaseNode>.broadcast();
  }
  factory DatabaseService() => _service;

  

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

  List<DatabaseNode> get allNodes => _nodes;

  List<DatabaseNode> getNodes(DateTime? filter, value) {
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

  Stream<DatabaseNode> getstream() => _nodesStreamController.stream;

  Future<void> deleteNode(DatabaseNode node) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final numberofdelete = await db.delete(
      nodetable,
      where: '$idcolumn = ? ',
      whereArgs: [node.id],
    );

    if (numberofdelete != 1) {
      throw UnableToDeleteException();
    }
    _nodes.removeWhere(
      (element) => element.id == node.id,
    );
    _nodesStreamController.add(node);
  }

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

    // adding nodes to local buffer
    final node = DatabaseNode.fromRow(values);
    _nodes.add(node);
    _nodesStreamController.add(node);
  }

  Future<void> _catchallNodes() async {
    _nodes = await _getallNodes();
    if (_nodes.isNotEmpty) {
      _nodesStreamController.add(_nodes[0]);
    }
  }

  Future<List<DatabaseNode>> _getallNodes() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final nodes = await db.query(nodetable);
    return nodes.map((map) => DatabaseNode.fromRow(map)).toList();
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

  Future<void> restartDatabase(String path) async {
    _db = await openDatabase(path);
    await _catchallNodes();
    if (_nodes == []) {
      _nodes = await _getallNodes();
      _nodesStreamController.add(_nodes.elementAt(0));
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

      // create the account table
      await db.execute(accountTable);
      
      // create the user table
      await db.execute(userTable);

      // create the catagory table
      await db.execute(catagoryTable);

      // create the sub catagory table
      await db.execute(subCatagoryTable);
  
      // Setting Values
      await _catchallNodes();

    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}
*/

class DatabaseService {
  Database? _db;

  late ValueNotifier<Iterable<DatabaseNode>> _currentNodes;
  late ValueNotifier<DatabaseUser?> _activeUser;

  late final UserService _userService;
  late final NodeService _nodeService;
  late final FilterService _filterService;

  static final DatabaseService _service = DatabaseService._sharedInstance();
  factory DatabaseService() => _service;
  DatabaseService._sharedInstance() {
    _userService = UserService();
    _nodeService = NodeService();
    _filterService = FilterService();
  }

  // User Variables
  ValueNotifier<DatabaseUser?> get userValueNotifier => _activeUser;
  // Get Active User
  DatabaseUser get activeUser => _userService.activeUser;
  // Get All Users
  Iterable<DatabaseUser> get getAllUsers => _userService.getUsers;

  // Node Variables
  ValueNotifier<Iterable<DatabaseNode>> get nodeValueLisnable => _currentNodes;

  int get sumIncome => _nodeService.totalIncome(_currentNodes.value);
  int get sumExpense => _nodeService.totalExpense(_currentNodes.value);
  int get sumBalance => _nodeService.balance(_currentNodes.value);

  int get maxNodeAmount => _nodeService.getMaxAmount(_currentNodes.value);

  Iterable<DatabaseNode> get allNodes => _currentNodes.value;
  // Users
  Future<void> createUser({
    required String username,
    required String info,
    String? imagePath,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _userService.createUser(
      db: db,
      username: username,
      info: info,
      imagePath: imagePath,
    );
    _activeUser.value = activeUser;
  }

  Future<void> deleteUser(int id) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _userService.deleteUser(db: db, id: id);
    _activeUser.value = activeUser;
  }

  Future<void> changeActiveUser(DatabaseUser user) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _userService.changeActiveuser(db: db, user: user);
    _activeUser.value = user;
  }

  Future<void> updateUser(Map<String, Object?> values) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    await _userService.updateUser(db: db, values: values);
    _activeUser.value = activeUser;
  }

  // Nodes
  List<DatabaseNode> filterNodes(DateTime? filter, value) {
    final nodes = _currentNodes.value;
    return _nodeService.filterNodes(nodes.toList(), filter, value);
  }

  Future<void> createNode({
    required int amount,
    required int catagoryId,
    required int subCatagoryId,
    required int isIncome,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _nodeService.createNode(
        db: db,
        amount: amount,
        catagoryId: catagoryId,
        subCatagoryId: subCatagoryId,
        isIncome: isIncome);
  }

  Future<void> deleteNode(DatabaseNode node) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _nodeService.deleteNode(db: db, node: node);
  }

  // Filters
  List<Filters> get filters => _filterService.allFilters;

  Future<void> createCatagory({
    required int userId,
    required String name,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _filterService.createCatagory(db: db, userId: userId, name: name);
  }

  Future<void> createSubCatagory({
    required int catagoryId,
    required String name,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _filterService.createSubCatagory(
        db: db, catagoryId: catagoryId, name: name);
  }

  Future<void> removeCatagory(int catagoryId) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _filterService.deleteCatagory(db: db, catagoryId: catagoryId);
  }

  Future<void> removeSubcatagory(
      {required int catagoryId, required int subCatagoryId}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _filterService.deleteSubCatagory(
        db: db, catagoryId: catagoryId, subCatagoryId: subCatagoryId);
  }

  // generics

  Future<void> initialiseUser() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    // load users
    try {
      await _userService.loadUsers(db);
    } on NoUsersFoundinDatabase {
      rethrow;
    }
  }

  Future<void> initialiseNodes() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    // grt active user
    final userid = activeUser.id;
    // load nodes
    await _nodeService.loadNodes(db: db, userId: userid);
    // load filters
    await _filterService.loadFilters(db: db, userId: userid);
    _activeUser.value = activeUser;
    _currentNodes.value = _nodeService.allNodes;
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

  Future<void> restoreDatabase(String path) async {
    _db = await openDatabase(path);
    try {
      await initialiseUser();
    } on NoUsersFoundinDatabase {
      rethrow;
    }

    await initialiseNodes();
  }

  Future<void> close() async {
    final db = _db;
    if (db != null) {
      _currentNodes.dispose();
      _activeUser.dispose();
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

      // create the account table
      await db.execute(accountTable);

      // create the user table
      await db.execute(userTable);

      // create the catagory table
      await db.execute(catagoryTable);

      // create the sub catagory table
      await db.execute(subCatagoryTable);
      // initialaise value notifiers
      _currentNodes = ValueNotifier(<DatabaseNode>[]);
      _activeUser = ValueNotifier(null);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}
