import 'package:dio/dio.dart';

import 'exceptions/exceptions.dart';
import 'models/error_response.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.response) {
      final bodyMap = err.response!.data as Map<String, dynamic>;
      final body = ErrorResponse.fromJson(bodyMap);
      if (body.validationErrors != null) {
        throw FieldsValidationException(body.validationErrors!);
      } else {
        throw ServerException(
          statusCode: body.statusCode,
          message: body.message,
        );
      }
    }
  }
}
