import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../api/api.dart';

final locator = GetIt.instance;

Future<void> registerServices() async {
  const baseUrl = 'https://tazkrtak-api-demo.herokuapp.com/';
  final client = Dio(BaseOptions(baseUrl: baseUrl));

  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  locator.registerLazySingleton(() => UserService(client));
}
