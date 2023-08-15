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
  final String? name;
  final String? info;
  final String? imagePath;
  const NodeEventUpdateUser({
    this.name,
    this.info,
    this.imagePath,
  });
}

class NodeEventCreateUser extends NodeEvent {
  final String username;
  final String info;
  const NodeEventCreateUser({
    required this.username,
    required this.info,
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