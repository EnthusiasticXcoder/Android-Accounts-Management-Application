import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/services/database_exceptions.dart';

import 'filter/filter.dart';
import 'node/node.dart';
import 'user/user.dart';

class DatabaseService {
  Database? _db;

  late final UserService _userService;
  late final NodeService _nodeService;
  late final FilterService _filterService;

  Iterable<DatabaseNode> _currentNode = [];

  static final DatabaseService _service = DatabaseService._sharedInstance();
  factory DatabaseService() => _service;
  DatabaseService._sharedInstance() {
    _userService = UserService();
    _nodeService = NodeService();
    _filterService = FilterService();
  }

  // Get All Users
  Iterable<DatabaseUser> get getAllUsers => _userService.getUsers;
  // Active User
  DatabaseUser get currentUser => _userService.activeUser;
  // Current Nodes

  int get sumIncome => _nodeService.totalIncome(_currentNode);
  int get sumExpense => _nodeService.totalExpense(_currentNode);
  int get sumBalance => _nodeService.balance(_currentNode);

  int get maxNodeAmount => _nodeService.getMaxAmount(_currentNode);

  List<int> get getMonths => _nodeService.getmonths;
  List<int> get getDates => _nodeService.getdates;
  List<int> get getYears => _nodeService.getyears;

  Iterable<DatabaseNode> get allNodes => _currentNode;

  // Users
  Future<void> createUser({
    required String username,
    required String info,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final newUser = await _userService.createUser(
      db: db,
      username: username,
      info: info,
    );
    await changeActiveUser(newUser);
  }

  Future<void> deleteUser(int id) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _userService.deleteUser(db: db, id: id);
    await changeActiveUser(getAllUsers.first);
  }

  Future<void> changeActiveUser(DatabaseUser user) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _userService.changeActiveuser(db: db, user: user);
    
  }

  Future<void> updateUser(
      {required int id, String? name, String? info, String? imagePath}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final activeUser = _userService.activeUser;
    final values = {
      namecolumn: (name != null) ? name : activeUser.name,
      infocolumn: (info != null) ? info : activeUser.info,
      isactivecolumn: 1
    };

    await _userService.updateUser(db: db, values: values);
  }

  // Nodes
  void filterNodes(FilterBy? filter) {
    if (filter == null) {
      _currentNode = _nodeService.allNodes;
    } else {
      final nodes = _nodeService.filterNodes(filter: filter);
      _currentNode = nodes;
    }
  }

  Iterable<DatabaseNode> filterNodesByIncome(
      Iterable<DatabaseNode>? nodes, bool isIncome) {
    return _nodeService.filterNodes(nodes: nodes, isIncome: isIncome);
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
        userId: _userService.activeUser.id,
        catagoryId: catagoryId,
        subCatagoryId: subCatagoryId,
        isIncome: isIncome);
    _currentNode = _nodeService.allNodes;
  }

  Future<void> deleteNode(int id) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await _nodeService.deleteNode(db: db, id: id);
    _currentNode = _nodeService.allNodes;
  }

  // Filters
  List<Filters> get filters => _filterService.allFilters;

  List<String> getCatagoryNameById(
      {required int catagoryId, required int subCatagoryId}) {
    return _filterService.getCatagoryNameById(
        catagoryId: catagoryId, subCatagoryId: subCatagoryId);
  }

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

    _currentNode = _nodeService.allNodes;
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
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}
