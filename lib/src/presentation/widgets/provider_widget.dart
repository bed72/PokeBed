import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bed/src/external/di/di.dart';

class ProviderWidget extends StatelessWidget {
  final Widget child;

  const ProviderWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: child,
    );
  }
}
