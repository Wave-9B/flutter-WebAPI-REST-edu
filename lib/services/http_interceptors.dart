// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';
import 'package:logger/logger.dart';

class Filter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}

final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // No method names in logs
    errorMethodCount: 0, // No method names in error logsZ
  ),
  filter: Filter(),
);

class LoggerInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    logger.i('----- Request -----');
    String body = '';
    if (request is Request) {
      body = request.body.isEmpty ? 'No body' : request.body;
    }
    logger.t(
      "Requisição para ${request.url}\nCabeçalhos: ${request.headers}\n Corpo: $body",
    );
    print(request.toString());
    print(request.headers.toString());
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    if (response.statusCode ~/ 100 == 2) {
      logger.i('Resposta bem-sucedida');
      logger.i('----- Response -----');
      logger.i('Code: ${response.statusCode}');
      if (response is Response) {
        logger.t('Body: ${(response).body}');
      }
    } else {
      logger.e('Resposta com erro: ${response.statusCode}');
    }

    return response;
  }
}
