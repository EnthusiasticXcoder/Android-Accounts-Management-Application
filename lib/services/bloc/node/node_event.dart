import 'package:flutter/foundation.dart' show immutable;
import 'package:my_app/services/services.dart';


@immutable
abstract class NodeEvent {
  const NodeEvent();
}

class NodeEventInitialise extends NodeEvent {
  const NodeEventInitialise();
}

class NodeEventUpdateUser extends NodeEvent {
  final int id;
  final String? name;
  final String? info;
  final String? imagePath;
  const NodeEventUpdateUser({
    required this.id,
    this.name,
    this.info,
    this.imagePath,
  });
}

class NodeEventCreateUser extends NodeEvent {
  final String username;
  final String info;
  final String? imagePath;
  const NodeEventCreateUser({
    required this.username,
    required this.info,
    this.imagePath,
  });
}

class NodeEventDeleteUser extends NodeEvent {
  final int userId;
  const NodeEventDeleteUser(this.userId);
}

class NodeEventChangeActiveUser extends NodeEvent {
  final DatabaseUser user;
  const NodeEventChangeActiveUser(this.user);
}
