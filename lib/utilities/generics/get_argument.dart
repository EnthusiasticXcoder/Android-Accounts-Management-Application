import 'package:flutter/material.dart' show BuildContext, MediaQuery;

extension GetArgument on BuildContext {
  double getminheight() {
    final mediaquery = MediaQuery.of(this);
    final args = mediaquery.size.height * 0.55;
    return args;
  }

  double getmaxheight() {
    final mediaquery = MediaQuery.of(this);
    final args = mediaquery.size.height * 0.68;
    return args;
  }

  double get height {
    final mediaquery = MediaQuery.of(this);
    return mediaquery.size.height;
  }

  double get width {
    final mediaquery = MediaQuery.of(this);
    return mediaquery.size.width;
  }
}
