import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bed/src/app.dart';
import 'package:bed/src/external/configs/start_config.dart';

Future<void> main() async => await runZonedGuarded<Future<void>>(
      () async {
        await startApplicationDependencies();

        runApp(const App());
      },
      (Object exception, StackTrace stack) => debugPrint('$exception\n $stack'),
    );
