import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';

extension Locator on Widget {
  GetIt get locator => GetIt.instance;
}
