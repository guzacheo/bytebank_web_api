import 'package:bytebank_armazen_interno/screens/dashboard.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const BytebankApp());
  }

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)
            .copyWith(secondary: Colors.blueAccent[700]),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        )
      ),
      home: const Dashboard(),
    );
  }
}
