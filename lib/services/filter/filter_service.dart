import 'package:sqflite/sqflite.dart';

import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/services/filter/database_filter.dart';
import '../database_exceptions.dart';

class FilterService {
  static final FilterService _service = FilterService._sharedInstance();
  FilterService._sharedInstance();
  factory FilterService() => _service;

  List<Filters> _catagory = [];

  List<Filters> get allFilters => _catagory;

  Future<void> createCatagory({
    required Database db,
    required int userId,
    required String name,
  }) async {
    final catagoryId = await db.insert(catagorytable, {
      userIdcolumn: userId,
      catagorynamecolumn: name,
    });

    List<Catagory> subcatagory = [];

    _catagory.add(Filters(
        catagory: Catagory(id: catagoryId, name: name),
        subcatagory: subcatagory));
  }

  Future<void> createSubCatagory({
    required Database db,
    required int catagoryId,
    required String name,
  }) async {
    final subCatagoryId = await db.insert(subcatagorytable, {
      catagoryIdcolumn: catagoryId,
      catagorynamecolumn: name,
    });

    final newFilter = _catagory.map((filter) {
      if (filter.catagory.id == catagoryId) {
        filter.subcatagory.add(Catagory(id: subCatagoryId, name: name));
      }
      return filter;
    });
    _catagory = [];
    _catagory.addAll(newFilter);
  }

  Future<void> deleteCatagory({
    required Database db,
    required int catagoryId,
  }) async {
    // Delete Catagory from catagory table
    final numberofdelete = await db
        .delete(catagorytable, where: '$idcolumn = ?', whereArgs: [catagoryId]);

    if (numberofdelete != 1) {
      throw UnableToDeleteException();
    } else {
      _catagory.removeWhere((element) => element.catagory.id == catagoryId);
    }
  }

  Future<void> deleteSubCatagory({
    required Database db,
    required int catagoryId,
    required int subCatagoryId,
  }) async {
    // Delete sub Catagory from catagory table
    final numberofdelete = await db.delete(subcatagorytable,
        where: '$idcolumn = ?', whereArgs: [subCatagoryId]);

    if (numberofdelete != 1) {
      throw UnableToDeleteException();
    } else {
      final newFilter = _catagory.map((filter) {
        if (filter.catagory.id == catagoryId) {
          filter.subcatagory
              .removeWhere((catagory) => catagory.id == subCatagoryId);
        }
        return filter;
      });
      _catagory = [];
      _catagory.addAll(newFilter);
    }
  }

  Future<void> loadFilters({
    required Database db,
    required int userId,
  }) async {
    final List<Filters> filter = [];
    final catagories = await getAllCatagory(db: db, userId: userId);

    for (var catagory in catagories) {
      final subCatagory =
          await getAllSubCatagory(db: db, catagoryId: catagory.id);

      filter.add(Filters(
        catagory: catagory,
        subcatagory: subCatagory.toList(),
      ));
    }
    _catagory = filter;
  }

  Future<Iterable<Catagory>> getAllCatagory({
    required Database db,
    required int userId,
  }) async {
    final catagory = await db.query(
      catagorytable,
      where: '$userIdcolumn = ?',
      whereArgs: [userId],
    );
    return catagory.map((item) => Catagory.fromRow(item));
  }

  Future<Iterable<Catagory>> getAllSubCatagory({
    required Database db,
    required int catagoryId,
  }) async {
    final subcatagory = await db.query(
      subcatagorytable,
      where: '$catagoryIdcolumn = ?',
      whereArgs: [catagoryId],
    );
    return subcatagory.map((item) => Catagory.fromRow(item));
  }
}
