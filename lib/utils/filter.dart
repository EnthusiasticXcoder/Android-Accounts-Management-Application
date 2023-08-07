import '../services/services.dart';

// filters Functions

List<Filters> get allFilters {
  // Get List of all the catagories and their sub catagory
  final service = DatabaseService();
  return service.filters;
}

List<String> getCatagoryNameById(
    {required int catagoryId, required int subCatagoryId}) {
  // get name of catagory and sub catagory with their id
  final service = DatabaseService();
  return service.getCatagoryNameById(
      catagoryId: catagoryId, subCatagoryId: subCatagoryId);
}

Future<void> createCatagory({required String name}) async {
  // Create A new Catagory
  final service = DatabaseService();
  await service.createCatagory(name);
}

Future<void> createSubCatagory(
    {required int catagoryId, required String name}) async {
  // Create A new sub Catagory
  final service = DatabaseService();
  await service.createSubCatagory(catagoryId: catagoryId, name: name);
}

Future<void> removeCatagory(int catagoryId) async {
  // Remove A catagory and all its sub catagory
  final service = DatabaseService();
  await service.removeCatagory(catagoryId);
}

Future<void> removeSubcatagory(
    {required int catagoryId, required int subCatagoryId}) async {
  // remove sub catagory of a perticular catagory
  final service = DatabaseService();
  await service.removeSubcatagory(
      catagoryId: catagoryId, subCatagoryId: subCatagoryId);
}
