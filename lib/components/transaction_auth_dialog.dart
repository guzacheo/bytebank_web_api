import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TransactionAuthDialog extends StatelessWidget {
  const TransactionAuthDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Authenticate'),
      content: const TextField(
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 64, letterSpacing: 32),
      ),
      actions: [
        TextButton(
          onPressed: () {
            print('cancel');
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            print('confirm');
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
