import 'dart:async';

import 'package:bytebank_web_api/screens/dashboard.dart';
import 'package:bytebank_web_api/screens/name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseCrashlytics.instance.setUserIdentifier('Alura123');
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  runZonedGuarded<Future<void>>(() async {
    runApp(const BytebankApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class LogObserver extends BlocObserver{
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint("${bloc.runtimeType} > $change");
    super.onChange(bloc, change);
  }
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: byteBankTheme,
      home: const DashboardContainer(),
    );
  }
}
