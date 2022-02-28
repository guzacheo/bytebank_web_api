import 'package:flutter/material.dart';

import '../components/centered_message.dart';
import '../components/progress.dart';
import '../http/webclients/transaction_webclient.dart';
import '../models/transactions.dart';

class TransactionsList extends StatelessWidget {
  TransactionsList({Key? key}) : super(key: key);
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: Future.delayed(const Duration(seconds: 1)).then((value) => _webClient.findAll()),
        builder: (context, snapshot) {
          final List<Transaction>? transactions = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress(text: 'Loading...',);
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if(transactions!.isNotEmpty){
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
              } else {
                return const CenteredMessage("No transactions registered",icon : Icons.warning);
              }
          } return const CenteredMessage('Unknown error...');
        },
      ),
      );
  }
}
