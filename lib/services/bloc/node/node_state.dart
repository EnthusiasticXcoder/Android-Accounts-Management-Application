import 'package:flutter/foundation.dart' show immutable;
import 'package:my_app/services/services.dart';


@immutable
abstract class NodeState {
  const NodeState();
}

class NodeLoadingState extends NodeState {
  const NodeLoadingState();
}

class NodeStateCreateUser extends NodeState {
  const NodeStateCreateUser();
}

class NodeStateUserExist extends NodeState {
  final DatabaseUser currentUser;
  final Iterable<DatabaseUser> allUsers;
  final String? message;
  const NodeStateUserExist({
    required this.currentUser,
    required this.allUsers,
    this.message,
  });
}
