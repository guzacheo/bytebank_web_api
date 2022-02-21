import 'package:bytebank_armazen_interno/components/centered_message.dart';
import 'package:bytebank_armazen_interno/database/webclient.dart';
import 'package:flutter/material.dart';

import '../components/progress.dart';
import '../models/contact.dart';
import '../models/transactions.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: Future.delayed(const Duration(seconds: 1)).then((value) => findAll()),
        builder: (context, snapshot) {
          final List<Transaction> transactions = snapshot.data!;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if(transactions.isNotEmpty){
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Transaction transaction = transactions[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.monetization_on),
                        title: Text(
                          transaction.value.toString(),
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          transaction.contact.accountNumber.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: transactions.length,
                );
              }
            break;
          } return CenteredMessage('Unknown error...');
        },
      ),
    );
  }
}
