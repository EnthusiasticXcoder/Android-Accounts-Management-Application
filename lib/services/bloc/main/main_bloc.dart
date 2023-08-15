import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:my_app/constants/crud_constants.dart';
import 'package:my_app/services/services.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(DatabaseService service)
      : super(
          MainStateHomePage(
            allNodes: service.allNodes,
            maxNodeAmount: service.maxNodeAmount,
            sumBalance: service.sumBalance,
            sumExpense: service.sumExpense,
            sumIncome: service.sumIncome,
            allfilters: service.filters,
            getCatagoryNameById: (catagoryId, subCatagoryId) =>
                service.getCatagoryNameById(
              catagoryId: catagoryId,
              subCatagoryId: subCatagoryId,
            ),
            filterNodeByIncome: (nodes, isIncome) =>
                service.filterNodesByIncome(nodes, isIncome),
          ),
        ) {
    // Open Filter Node Dialogg
    on<MainEventFilteringNode>((event, emit) {
      emit(MainStateFilteringNode(
        dateList: service.getDates,
        monthList: service.getMonths,
        yearList: service.getYears,
      ));
    });

    // Open Create node Dialog
    on<MainEventCreateingNode>((event, emit) {
      emit(MainStateCreatedNode(event.isIncome));
    });

    // Open Display Node Data Dialog
    on<MainEventDisplayNode>((event, emit) {
      emit(MainStateDisplayNode(
        amount: event.amount,
        catagory: event.catagory,
        dateTime: event.dateTime,
        id: event.id,
        statusColor: event.statusColor,
        subcatagory: event.subcatagory,
      ));
    });

    // Event On Pop Of Dialof For State Home Page
    on<MainEventHideDialog>((event, emit) {
      emit(
        MainStateHomePage(
          allNodes: service.allNodes,
          maxNodeAmount: service.maxNodeAmount,
          sumBalance: service.sumBalance,
          sumExpense: service.sumExpense,
          sumIncome: service.sumIncome,
          allfilters: service.filters,
          getCatagoryNameById: (catagoryId, subCatagoryId) =>
              service.getCatagoryNameById(
            catagoryId: catagoryId,
            subCatagoryId: subCatagoryId,
          ),
          filterNodeByIncome: (nodes, isIncome) =>
              service.filterNodesByIncome(nodes, isIncome),
        ),
      );
    });

    // Create Node Event
    on<MainEventCreateNode>((event, emit) async {
      try {
        await service.createNode(
          amount: event.amount,
          catagoryId: event.catagoryId,
          subCatagoryId: event.subCatagoryId,
          isIncome: event.isIncome,
        );
        emit(
          MainStateHomePage(
            message: 'Entry Created Successfully!',
            allNodes: service.allNodes,
            maxNodeAmount: service.maxNodeAmount,
            sumBalance: service.sumBalance,
            sumExpense: service.sumExpense,
            sumIncome: service.sumIncome,
            allfilters: service.filters,
            getCatagoryNameById: (catagoryId, subCatagoryId) =>
                service.getCatagoryNameById(
              catagoryId: catagoryId,
              subCatagoryId: subCatagoryId,
            ),
            filterNodeByIncome: (nodes, isIncome) =>
                service.filterNodesByIncome(nodes, isIncome),
          ),
        );
      } on Exception {
        emit(
          MainStateHomePage(
            message: 'Unable To Create Entry',
            allNodes: service.allNodes,
            maxNodeAmount: service.maxNodeAmount,
            sumBalance: service.sumBalance,
            sumExpense: service.sumExpense,
            sumIncome: service.sumIncome,
            allfilters: service.filters,
            getCatagoryNameById: (catagoryId, subCatagoryId) =>
                service.getCatagoryNameById(
              catagoryId: catagoryId,
              subCatagoryId: subCatagoryId,
            ),
            filterNodeByIncome: (nodes, isIncome) =>
                service.filterNodesByIncome(nodes, isIncome),
          ),
        );
      }
    });

    // Filter Node Event
    on<MainEventFilterNode>((event, emit) {
      service.filterNodes(event.filter);
      emit(
        MainStateHomePage(
          allNodes: service.allNodes,
          maxNodeAmount: service.maxNodeAmount,
          sumBalance: service.sumBalance,
          sumExpense: service.sumExpense,
          sumIncome: service.sumIncome,
          allfilters: service.filters,
          getCatagoryNameById: (catagoryId, subCatagoryId) =>
              service.getCatagoryNameById(
            catagoryId: catagoryId,
            subCatagoryId: subCatagoryId,
          ),
          filterNodeByIncome: (nodes, isIncome) =>
              service.filterNodesByIncome(nodes, isIncome),
        ),
      );
    });

    // Delete Node Event
    on<MainEventDeleteNode>((event, emit) async {
      await service.deleteNode(event.id);
      emit(
        MainStateHomePage(
          message: 'Entry Deleted Sucessfully',
          allNodes: service.allNodes,
          maxNodeAmount: service.maxNodeAmount,
          sumBalance: service.sumBalance,
          sumExpense: service.sumExpense,
          sumIncome: service.sumIncome,
          allfilters: service.filters,
          getCatagoryNameById: (catagoryId, subCatagoryId) =>
              service.getCatagoryNameById(
            catagoryId: catagoryId,
            subCatagoryId: subCatagoryId,
          ),
          filterNodeByIncome: (nodes, isIncome) =>
              service.filterNodesByIncome(nodes, isIncome),
        ),
      );
    });

    // Share Data Event
    on<MainEventShare>(
      (event, emit) async {
        // import export settings function

        final docsPath = await getApplicationDocumentsDirectory();
        final dbPath = join(docsPath.path, dbName);

        await Share.shareXFiles([XFile(dbPath)]);
      },
    );

    // Import Data Event
    on<MainEventImport>((event, emit) async {
      final filePath = await FilePicker.platform.pickFiles();
      final path = filePath!.files.first.path;

      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);

      await File(dbPath).delete();
      await File(path!).copy(dbPath);

      try {
        await service.restoreDatabase(path);
      } on NoUsersFoundinDatabase {
        event.event();
        return;
      }
      event.event;
      emit(
        MainStateHomePage(
          message: 'Data Successfully Imported',
          allNodes: service.allNodes,
          maxNodeAmount: service.maxNodeAmount,
          sumBalance: service.sumBalance,
          sumExpense: service.sumExpense,
          sumIncome: service.sumIncome,
          allfilters: service.filters,
          getCatagoryNameById: (catagoryId, subCatagoryId) =>
              service.getCatagoryNameById(
            catagoryId: catagoryId,
            subCatagoryId: subCatagoryId,
          ),
          filterNodeByIncome: (nodes, isIncome) =>
              service.filterNodesByIncome(nodes, isIncome),
        ),
      );
    });

    // Create Catagory Event
    on<MainEventCreateCatagory>((event, emit) async {
      await service.createCatagory(event.name);
      emit(
        MainStateHomePage(
          message: 'Catagory Created : ${event.name}',
          allNodes: service.allNodes,
          maxNodeAmount: service.maxNodeAmount,
          sumBalance: service.sumBalance,
          sumExpense: service.sumExpense,
          sumIncome: service.sumIncome,
          allfilters: service.filters,
          getCatagoryNameById: (catagoryId, subCatagoryId) =>
              service.getCatagoryNameById(
            catagoryId: catagoryId,
            subCatagoryId: subCatagoryId,
          ),
          filterNodeByIncome: (nodes, isIncome) =>
              service.filterNodesByIncome(nodes, isIncome),
        ),
      );
    });

    // Create Subcatagory Event
    on<MainEventCreateSubCatagory>((event, emit) async {
      await service.createSubCatagory(catagoryId: event.id, name: event.name);
      emit(
        MainStateHomePage(
          message: 'SubCatagory Created : ${event.name}',
          allNodes: service.allNodes,
          maxNodeAmount: service.maxNodeAmount,
          sumBalance: service.sumBalance,
          sumExpense: service.sumExpense,
          sumIncome: service.sumIncome,
          allfilters: service.filters,
          getCatagoryNameById: (catagoryId, subCatagoryId) =>
              service.getCatagoryNameById(
            catagoryId: catagoryId,
            subCatagoryId: subCatagoryId,
          ),
          filterNodeByIncome: (nodes, isIncome) =>
              service.filterNodesByIncome(nodes, isIncome),
        ),
      );
    });

    // Remove Catagory Event
    on<MainEventRemoveCatagory>((event, emit) async {
      await service.removeCatagory(event.id);
      emit(
        MainStateHomePage(
          message: 'Catagory Removed successfully',
          allNodes: service.allNodes,
          maxNodeAmount: service.maxNodeAmount,
          sumBalance: service.sumBalance,
          sumExpense: service.sumExpense,
          sumIncome: service.sumIncome,
          allfilters: service.filters,
          getCatagoryNameById: (catagoryId, subCatagoryId) =>
              service.getCatagoryNameById(
            catagoryId: catagoryId,
            subCatagoryId: subCatagoryId,
          ),
          filterNodeByIncome: (nodes, isIncome) =>
              service.filterNodesByIncome(nodes, isIncome),
        ),
      );
    });

    // Remove sub Catagory Event
    on<MainEventRemoveSubCatagory>((event, emit) async {
      await service.removeSubcatagory(
        catagoryId: event.id,
        subCatagoryId: event.subId,
      );
      emit(
        MainStateHomePage(
          message: 'SubCatagory Removed successfully',
          allNodes: service.allNodes,
          maxNodeAmount: service.maxNodeAmount,
          sumBalance: service.sumBalance,
          sumExpense: service.sumExpense,
          sumIncome: service.sumIncome,
          allfilters: service.filters,
          getCatagoryNameById: (catagoryId, subCatagoryId) =>
              service.getCatagoryNameById(
            catagoryId: catagoryId,
            subCatagoryId: subCatagoryId,
          ),
          filterNodeByIncome: (nodes, isIncome) =>
              service.filterNodesByIncome(nodes, isIncome),
        ),
      );
    });
  }
}
