import 'package:flutter/material.dart';

final byteBankTheme = ThemeData(
    primaryColor: Colors.green[900],
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)
        .copyWith(secondary: Colors.blueAccent[700]),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent[700],
      textTheme: ButtonTextTheme.primary,
    ));