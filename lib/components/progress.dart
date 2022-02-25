import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  const Progress({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        )
      ],
    ));
  }
}
