import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api/api.dart';

final locator = GetIt.instance;

void registerServices() {
  const baseUrl = 'https://tazkrtak-api-demo.herokuapp.com/';
  final client = Dio(BaseOptions(baseUrl: baseUrl));
  locator.registerLazySingleton(() => HelloService(client));
}
