import 'dart:core';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import 'interceptors/logging_interceptor.dart';

final Uri baseUrl = Uri.parse('http://192.168.0.62:8080/transactions');
final Client client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);




