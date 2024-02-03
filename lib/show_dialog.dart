import 'package:flutter/material.dart';
Future<void> showRecycledDialog(BuildContext context, List<String> recycledItems) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Recycling Successful'),
        content: Text('You recycled the following items:\n${recycledItems.join('\n')}'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
