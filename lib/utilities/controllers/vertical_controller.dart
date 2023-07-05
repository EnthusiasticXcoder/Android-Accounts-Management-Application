import 'package:flutter/material.dart' show ScrollController;

class VerticalController {
  ScrollController? _controller;

  static final _shared = VerticalController._sharedInstance();
  VerticalController._sharedInstance();
  factory VerticalController() => _shared;

  ScrollController get getcontroller => _controller!;

  void setcontroller(ScrollController controller) {
    try {
      _controller = controller;
    } catch (e) {
      rethrow;
    }
  }
}