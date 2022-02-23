// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {

  final Function(String password)? onConfirm;

  const TransactionAuthDialog({Key? key, @required this.onConfirm}) : super(key: key);

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Authenticate'),
      content: TextField(
        controller: _passwordController,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 64, letterSpacing: 24),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            print('cancel');
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirm!(_passwordController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Confirm'),
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
    );
  }
}
