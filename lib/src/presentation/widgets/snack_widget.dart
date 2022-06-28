import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarWidget({
  required String message,
  required BuildContext context,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 6),
      action: SnackBarAction(
        onPressed: () {},
        textColor: Theme.of(context).colorScheme.background,
        label: 'Ok',
      ),
    ),
  );
}
