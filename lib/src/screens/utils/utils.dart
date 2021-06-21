import 'package:flutter/material.dart';

void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información incorrecta'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}
