import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../api/api.dart';

final locator = GetIt.instance;

Future<void> registerServices() async {
  // BLoC Services
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  // API Services
  const baseUrl = 'https://tazkrtak-api-demo.herokuapp.com/';
  final client = ApiClient(baseUrl);
  locator.registerFactory(() => client);
  locator.registerLazySingleton(() => UserService(client.dio));
  locator.registerLazySingleton(() => TransactionsService(client.dio));
}
