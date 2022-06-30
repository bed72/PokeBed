import 'package:flutter/material.dart';

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void createdWidget();
  void destroyWidget();

  @override
  void initState() {
    super.initState();
    createdWidget();
    // WidgetsBinding.instance.addPostFrameCallback((_) => createdWidget());
  }

  @override
  void dispose() {
    destroyWidget();
    super.dispose();
  }
}
