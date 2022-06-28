import 'dart:async';

import 'package:flutter/widgets.dart';

class CallDebounce {
  late VoidCallback action;
  late final int milliseconds;

  Timer _timer = Timer(const Duration(milliseconds: 200), () {});

  CallDebounce({
    required this.milliseconds,
  });

  void run(VoidCallback action) {
    // ignore: unnecessary_null_comparison
    if (_timer != null) _timer.cancel();

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
