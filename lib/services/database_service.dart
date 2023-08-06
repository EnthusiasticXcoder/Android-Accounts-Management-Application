import 'package:flutter/foundation.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/services/database_exceptions.dart';

import 'package:my_app/services/filter/filter_service.dart';
import 'package:my_app/services/user/user_service.dart';
import 'package:my_app/services/node/node_service.dart';

import 'filter/database_filter.dart';
import 'node/database_node.dart';
import 'user/database_user.dart';

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
    _activeUser.value = _userService.activeUser;
    initialiseNodes();
  }

  Future<void> deleteUser(int id) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _userService.deleteUser(db: db, id: id);
    _activeUser.value = _userService.activeUser;
    initialiseNodes();
  }

  Future<void> changeActiveUser(DatabaseUser user) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _userService.changeActiveuser(db: db, user: user);
    _activeUser.value = user;
    initialiseNodes();
  }

  Future<void> updateUser(
      {required int id, String? name, String? info, String? imagePath}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final activeUser = _userService.activeUser;
    final values = {
      namecolumn: (name != null) ? name : activeUser.name,
      infocolumn: (info != null) ? info : activeUser.info,
      imageColumn: (imagePath != null) ? imagePath : activeUser.imagePath,
      isactivecolumn: 1
    };

    await _userService.updateUser(db: db, values: values);
    _activeUser.value = _userService.activeUser;
  }

  // Nodes
  void filterNodes(FilterBy? filter, value) {
    final nodes = _nodeService.filterNodes(
        nodes: _currentNodes.value, filter: filter, isIncome: value);
    _currentNodes.value = nodes;
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

  Future<void> createCatagory(
    String name,
  ) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _filterService.createCatagory(
        db: db, userId: _userService.activeUser.id, name: name);
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
    // get active user
    final activeuser = _userService.activeUser;
    // load nodes
    await _nodeService.loadNodes(db: db, userId: activeuser.id);
    // load filters
    await _filterService.loadFilters(db: db, userId: activeuser.id);
    _activeUser.value = activeuser;
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
