import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String splashPath = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Bed'),
        ),
      ),
    );
  }
}
