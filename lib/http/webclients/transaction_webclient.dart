// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart';

// ignore: unused_import
import '../../models/contact.dart';
import '../../models/transactions.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(const Duration(seconds: 5));
    final List<dynamic> decodedJason = jsonDecode(response.body);

    print('decoded Json: $decodedJason');

    final List<dynamic> decodedJson = jsonDecode(response.body);
    //map itera o decodedjson, substituindo o for abaixo e o toList() converte de Iterable para List
    final List<Transaction> transactions =
    decodedJson.map((dynamic json) => Transaction.fromJson(json)).toList();
    //converter o Json
    return transactions;
  }
//
  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post(baseUrl,
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: transactionJson);
    return Transaction.fromJson(jsonDecode(response.body));
  }

  // List<Transaction> _toTransactions(Response response) {
  //   // final List<dynamic> decodedJson = jsonDecode(response.body);
  //   // //map itera o decodedjson, substituindo o for abaixo e o toList() converte de Iterable para List
  //   // final List<Transaction> transactions =
  //   //     decodedJson.map((dynamic json) => Transaction.fromJson(json)).toList();
  //   //cria a lista
  //   // final List<Transaction> transactions = [];
  //   //iteracao para todos os elementos do json recebido
  //   // for (Map<String, dynamic> transactionJson in decodedJson) {
  //   //usando o conversor de Transaction()
  //   // //instancia o contato do json
  //   // final Map<String, dynamic> contactJson = transactionJson['contact'];
  //   // //cria a transacao
  //   // final Transaction transaction = Transaction(
  //   //   transactionJson['value'],
  //   //   Contact(contactJson['name'], contactJson['accountNumber'], 0),
  //   // );
  //   //adiciona a transacao na lista
  //
  //   // }
  //   return transactions;
  // }

  // Map<String, dynamic> _toMap(Transaction transaction) {
  //   final Map<String, dynamic> transactionMap = {
  //     'value': transaction.value,
  //     'contact': {
  //       'name': transaction.contact.name,
  //       'accountNumber': transaction.contact.accountNumber,
  //     }
  //   };
  //   return transactionMap;
  // }
}
