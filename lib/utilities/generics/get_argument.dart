import 'package:flutter/material.dart' show BuildContext, MediaQuery;

extension GetArgument on BuildContext {

  double getminheight() {
    final mediaquery = MediaQuery.of(this);
    final args = mediaquery.size.height * 0.55;
    return args;
  }

  double getmaxheight() {
    final mediaquery = MediaQuery.of(this);
    final args = mediaquery.size.height * 0.7;
    return args;
  }
}
