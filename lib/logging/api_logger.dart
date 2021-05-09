import 'package:dio/dio.dart';

import 'logger.dart';
import 'pretty_json.dart';

class ApiLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    final message = StringBuffer();
    message.writeAll([
      '[ ${options.method} REQUEST ] > ${options.uri}\n',
      ...options.headers.entries.map((h) => '${h.key}: ${h.value}'),
      '\n${prettyJson(options.data)}',
    ], '\n');

    logger.i(message);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    final message = StringBuffer();
    message.writeAll([
      '[ RESPONSE ${response.statusCode} ] < ${response.realUri}\n',
      ...response.headers.map.entries.map((h) => '${h.key}: ${h.value}'),
      '\n${prettyJson(response.data)}',
    ], '\n');

    logger.i(message);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    final message = StringBuffer();
    message.writeAll([
      '[ ERROR ] : ${err.requestOptions.uri}\n',
      err.message,
      '\n${prettyJson(err.response?.data)}',
    ], '\n');

    logger.e(message);
  }
}
