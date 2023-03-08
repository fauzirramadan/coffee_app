import 'package:flutter/material.dart';

import '../app/app.dart';

class NotifUtils {
  static void showSnackbar(String message,
      {Color? backgroundColor, SnackBarAction? action}) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        action: action,
        content: Text(message),
      ),
    );
  }
}
