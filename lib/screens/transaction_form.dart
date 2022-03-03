// ignore_for_file: unnecessary_null_comparison, unused_element

import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../components/progress.dart';
import '../components/response_dialog.dart';
import '../components/transaction_auth_dialog.dart';
import '../http/webclients/transaction_webclient.dart';
import '../models/contact.dart';
import '../models/transactions.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm(this.contact, {Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = const Uuid().v4();
  bool _sending = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('transaction form id: $transactionId');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Progress(
                    text: 'Sending...',
                  ),
                ),
                visible: _sending,
              ),
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      final transactionCreated = Transaction(
                        transactionId,
                        value,
                        widget.contact,
                      );
                      showDialog(
                        context: context,
                        builder: (dialogContext) => TransactionAuthDialog(
                          onConfirm: (String password) {
                            _save(transactionCreated, password, context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    Transaction? transaction = await _send(
      transactionCreated,
      password,
      context,
    );

    await _showSuccessfulMessage(transaction, context);
  }

  Future<void> _showSuccessfulMessage(
      Transaction? transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('successful transaction');
          });
      Navigator.pop(context);
    }
  }

  Future<Transaction?> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    setState(() {
      _sending = true;
    });
    final Transaction? transaction =
        await _webClient.save(transactionCreated, password).catchError((e) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance.setCustomKey('Exception', e.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('http_body:', transactionCreated.toString());
        FirebaseCrashlytics.instance.setCustomKey('http_code:', e.statusCode);
        FirebaseCrashlytics.instance.recordError(e.message, null);
      }

      _showFailureDialog(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance.setCustomKey('Exception', e.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('http_body:', transactionCreated.toString());
        FirebaseCrashlytics.instance.setCustomKey('http_code:', e.statusCode);
        FirebaseCrashlytics.instance.recordError(e.message, null);
      }

      _showFailureDialog(context,
          message: "Timeout submitting the transaction");
    }, test: (e) => e is TimeoutException).catchError(
      (e) {
        if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
          FirebaseCrashlytics.instance.setCustomKey('Exception', e.toString());
          FirebaseCrashlytics.instance
              .setCustomKey('http_body:', transactionCreated.toString());
          FirebaseCrashlytics.instance.setCustomKey('http_code:', e.statusCode);
          FirebaseCrashlytics.instance.recordError(e.message, null);
        }

        _showFailureDialog(context,
            message: "Timeout submitting the transaction");
      },
    ).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });
    return transaction;
  }

  void _showFailureDialog(BuildContext context,
      {String message = "Unknown Error..."}) {
    final snackBar = SnackBar(content: Text(message),);
    _scaffoldKey.currentState?.showSnackBar(snackBar);
    // showDialog(
    //     context: context,
    //     builder: (contextDialog) {
    //       return FailureDialog(message);
    //     });
  }
}
