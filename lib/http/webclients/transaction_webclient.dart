import 'dart:convert';

import 'package:http/http.dart';

import '../../models/contact.dart';
import '../../models/transactions.dart';
import '../webclient.dart';

class TransactionWebClient{

Future<List<Transaction>> findAll() async {
  final Response response =
  await client.get(baseUrl).timeout(const Duration(seconds: 5));
  final List<dynamic> decodedJason = jsonDecode(response.body);

  print('decoded Json: $decodedJason');

  //converter o Json
  List<Transaction> transactions = _toTransactions(response);
  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final String transactionJson = jsonEncode(transaction.toJson());
  final Response response = await client.post(baseUrl,
      headers: {'Content-type': 'application/json', 'password': '1000'},
      body: transactionJson);
  return _toTransaction(response);
}

List<Transaction> _toTransactions(Response response) {
  final List<dynamic> decodedJson = jsonDecode(response.body);
  //cria a lista
  final List<Transaction> transactions = [];
  //iteracao para todos os elementos do json recebido
  for (Map<String, dynamic> transactionJson in decodedJson) {
    //usando o conversor de Transaction()
    transactions.add(Transaction.fromJson(transactionJson));
    // //instancia o contato do json
    // final Map<String, dynamic> contactJson = transactionJson['contact'];
    // //cria a transacao
    // final Transaction transaction = Transaction(
    //   transactionJson['value'],
    //   Contact(contactJson['name'], contactJson['accountNumber'], 0),
    // );
    //adiciona a transacao na lista

  }
  return transactions;
}

Transaction _toTransaction(Response response) {
   Map<String, dynamic> json = jsonDecode(response.body);
   return Transaction.fromJson(json);
}

Map<String, dynamic> _toMap(Transaction transaction) {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber,
    }
  };
  return transactionMap;
}}