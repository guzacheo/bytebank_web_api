import 'package:bytebank_armazen_interno/components/transaction_auth_dialog.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                        showDialog(
                          context: context,
                          builder: (dialogContext) => TransactionAuthDialog(
                            onConfirm: (String password) {
                              final double? value = double.tryParse(_valueController.text);
                              final transactionCreated = Transaction(value!, widget.contact);
                              _webClient.save(transactionCreated, password).then((transactionReceived) {
                                Navigator.pop(context);
                              });
                              debugPrint(password);
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
}
