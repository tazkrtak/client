import 'dart:io';

import 'package:dio/dio.dart';

import 'error/error_interceptor.dart';

class ApiClient {
  static Interceptor? observer;
  final Dio dio;

  ApiClient(String baseUrl)
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
          ),
        ) {
    if (observer != null) {
      // Logging interceptor must be added first, to log server error response
      dio.interceptors.add(observer!);
    }

    dio.interceptors.add(ErrorInterceptor());
  }

  void authorize(String token) {
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  }

  void unauthorize() {
    dio.options.headers.remove(HttpHeaders.authorizationHeader);
  }
}
