import 'package:flutter/foundation.dart' show immutable, VoidCallback;
import 'package:my_app/services/services.dart';


@immutable
abstract class MainEvent {
  const MainEvent();
}

class MainEventCreateNode extends MainEvent {
  final int amount;
  final int catagoryId;
  final int subCatagoryId;
  final int isIncome;
  const MainEventCreateNode({
    required this.amount,
    required this.catagoryId,
    required this.subCatagoryId,
    required this.isIncome,
  });
}

class MainEventShare extends MainEvent {
  const MainEventShare();
}

class MainEventImport extends MainEvent {
  final VoidCallback event;
  const MainEventImport(this.event);
}

class MainEventFilterNode extends MainEvent {
  final FilterBy? filter;
  const MainEventFilterNode(this.filter);
}

class MainEventHideDialog extends MainEvent {
  const MainEventHideDialog();
}

class MainEventDeleteNode extends MainEvent {
  final int id;
  const MainEventDeleteNode(this.id);
}

class MainEventCreateingNode extends MainEvent {
  final bool isIncome;
  const MainEventCreateingNode(this.isIncome);
}

class MainEventDisplayNode extends MainEvent {
  final int id;
  final String amount;
  final String catagory, subcatagory, dateTime;
  final bool statusColor;

  const MainEventDisplayNode({
    required this.id,
    required this.amount,
    required this.catagory,
    required this.subcatagory,
    required this.dateTime,
    required this.statusColor,
  });
}

class MainEventFilteringNode extends MainEvent {
  const MainEventFilteringNode();
}

class MainEventCreateCatagory extends MainEvent {
  final String name;
  const MainEventCreateCatagory(this.name);
}

class MainEventCreateSubCatagory extends MainEvent {
  final int id;
  final String name;
  const MainEventCreateSubCatagory(
    this.id,
    this.name,
  );
}

class MainEventRemoveCatagory extends MainEvent {
  final int id;
  const MainEventRemoveCatagory(this.id);
}

class MainEventRemoveSubCatagory extends MainEvent {
  final int id;
  final int subId;
  const MainEventRemoveSubCatagory(this.id, this.subId);
}
