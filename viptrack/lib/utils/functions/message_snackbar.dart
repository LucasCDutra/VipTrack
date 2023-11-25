import 'package:flutter/material.dart';

void message(BuildContext context, String message, bool success) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 130),
    content: Text(message),
    backgroundColor: success ? Colors.green : Colors.red,
  ));
}
