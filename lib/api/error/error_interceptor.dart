import 'package:dio/dio.dart';

import 'exceptions/exceptions.dart';
import 'models/error_response.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final body =
          ErrorResponse.fromJson(err.response!.data as Map<String, dynamic>);
      if (err.response!.statusCode! > 400 && err.response!.statusCode! < 500) {
        throw FieldsValidationException(body.validationErrors);
      }
    }
  }
}
