import 'package:dio/dio.dart';

class ApiClient {
  static Interceptor? observer;

  ApiClient._();

  static Dio create(String baseUrl) {
    final options = BaseOptions(baseUrl: baseUrl);
    final client = Dio(options);

    if (observer != null) {
      client.interceptors.add(observer!);
    }

    return client;
  }
}
