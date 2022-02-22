import 'dart:convert';
import 'dart:core';
import 'package:bytebank_armazen_interno/models/transactions.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

import '../models/contact.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('------------Request------------');
    print('URL: ${data.url}');
    print('Headers: ${data.headers}');
    print('Body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('------------Response------------');
    print('URL: ${data.statusCode}');
    print('Headers: ${data.headers}');
    print('Body: ${data.body}');
    return data;
  }
}

final Uri baseUrl = Uri.parse('http://192.168.0.62:8080/transactions');
final Client client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);

Future<List<Transaction>> findAll() async {
  final Response response =
      await client.get(baseUrl).timeout(const Duration(seconds: 5));
  final List<dynamic> decodedJason = jsonDecode(response.body);

  print('decoded Json: $decodedJason');

  //converter o Json
  final List<dynamic> decodedJson = jsonDecode(response.body);
  //cria a lista
  final List<Transaction> transactions = [];
  //iteracao para todos os elementos do json recebido
  for (Map<String, dynamic> transactionJson in decodedJson) {
    //instancia o contato do json
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    //cria a transacao
    final Transaction transaction = Transaction(
      transactionJson['value'],
      Contact(contactJson['name'], contactJson['accountNumber'], 0),
    );
    //adiciona a transacao na lista
    transactions.add(transaction);
  }
  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber,
    }
  };

  final String transactionJson = jsonEncode(transactionMap);
  final Response response = await client.post(baseUrl,
      headers: {'Content-type': 'application/json', 'password': '1000'},
      body: transactionJson);
  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(
    json['value'],
    Contact(contactJson['name'], contactJson['accountNumber'], 0),
  );
}
