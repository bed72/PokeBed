import 'package:flutter/material.dart';

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void createdWidget();
  void destroyWidget();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => createdWidget());
    super.initState();
  }

  @override
  void dispose() {
    destroyWidget();
    super.dispose();
  }
}
