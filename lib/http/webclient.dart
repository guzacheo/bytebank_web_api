import 'dart:convert';
import 'dart:core';
import 'package:bytebank_armazen_interno/models/transactions.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

import '../models/contact.dart';
import 'interceptors/logging_interceptor.dart';

final Uri baseUrl = Uri.parse('http://192.168.0.62:8080/transactions');
final Client client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);




