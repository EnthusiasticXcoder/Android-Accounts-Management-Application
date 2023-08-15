import 'package:sqflite/sqflite.dart';

import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/services/user/database_user.dart';
import '../database_exceptions.dart';

class UserService {
  
  Iterable<DatabaseUser> _users = [];
  DatabaseUser? _activeUser;

  DatabaseUser get activeUser => _activeUser!;
  Iterable<DatabaseUser> get getUsers => _users;

  Future<DatabaseUser> createUser(
      {required Database db,
      required String username,
      required String info,
      String? imagePath}) async {
    final id = await db.insert(
      usertable,
      {
        namecolumn: username,
        infocolumn: info,
        imageColumn: imagePath,
        isactivecolumn: 1
      },
    );
    final newUser = DatabaseUser(
        id: id,
        name: username,
        info: info,
        imagePath: imagePath,
        isactive: true);

    _users.map((user) {
      user.isactive = false;
      return user;
    }).followedBy([newUser]);

    return newUser;
  }

  Future<void> deleteUser({required Database db, required int id}) async {
    final numberofdelete = await db.delete(
      usertable,
      where: '$idcolumn = ?',
      whereArgs: [id],
    );

    if (numberofdelete != 1) {
      throw UnableToDeleteException();
    } else {
      _users = _users.where((element) => element.id != id);
      if (_users.isEmpty) {
        throw AllUserDeleted();
      }
    }
  }

  Future<void> updateUser(
      {required Database db, required Map<String, Object?> values}) async {
    final updatesCount = await db.update(
      usertable,
      values,
      where: '$idcolumn = ?',
      whereArgs: [activeUser.id],
    );
    if (updatesCount == 0) {
      throw CouldNotUpdateNote();
    } else {
      values.addAll({idcolumn: activeUser.id});
      final user = DatabaseUser.fromrow(values);
      _users.map((element) => (element.id == activeUser.id) ? user : element);
      _activeUser = user;
    }
  }

  Future<void> changeActiveuser(
      {required Database db, required DatabaseUser user}) async {
    await db.update(usertable, {
      isactivecolumn: 0,
    });

    final updateCount = await db.update(
      usertable,
      {isactivecolumn: 1},
      where: '$idcolumn = ?',
      whereArgs: [user.id],
    );

    if (updateCount == 0) {
      throw CouldNotUpdateNote();
    } else {
      _users.map((item) {
        (item.id == user.id) ? user.isactive = true : user.isactive = false;
        return user;
      });
      _activeUser = user;
    }
  }

  Future<void> loadUsers(Database db) async {
    final users = await db.query(
      usertable,
    );
    if (users.isEmpty) {
      throw NoUsersFoundinDatabase();
    }

    final user = users.map((map) => DatabaseUser.fromrow(map));
    _users = user;
    if (user.length == 1) {
      _activeUser = user.first;
    } else {
      _activeUser = user.firstWhere((element) => element.isactive == true);
    }
  }
}
