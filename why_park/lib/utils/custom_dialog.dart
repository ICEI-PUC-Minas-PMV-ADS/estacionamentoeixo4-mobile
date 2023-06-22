import 'package:flutter/material.dart';
import '../../../utils/state_status.dart';

class CustomDialog {
  static showCustomDialog(final BuildContext context, Status status,
      String titleMessage, String bodyMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            titleMessage,
            style: const TextStyle(color: Colors.black),
          ),
          content: Text(
            bodyMessage,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
