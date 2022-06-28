import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import 'package:bed/src/external/singletons/storage_singleton.dart';
import 'package:bed/src/external/singletons/navigation_singleton.dart';

Future<void> startApplicationDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  await _startSingletons();
}

Future<void> _startSingletons() async {
  NavigationSingleton.instance.initialized();
  await StorageSingleton.instance.initialized();
}
