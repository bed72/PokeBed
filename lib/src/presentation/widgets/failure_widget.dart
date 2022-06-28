import 'package:flutter/material.dart';

Widget failureMessageWidget({required String message}) => Center(
      child: Text(message),
    );

Widget failureIconWidget() => const Center(
      child: Icon(
        Icons.wifi_off_outlined,
        size: 48,
      ),
    );
