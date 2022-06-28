import 'package:flutter/widgets.dart';

import 'package:bed/src/external/di/di.dart';

import 'package:bed/src/external/singletons/storage_singleton.dart';
import 'package:bed/src/external/singletons/navigation_singleton.dart';

Future<void> startApplicationDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  Inject.initialized();
  await _startSingletons();
}

Future<void> _startSingletons() async {
  NavigationSingleton.instance.initialized();
  await StorageSingleton.instance.initialized();
}
