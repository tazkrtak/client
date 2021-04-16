import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../api/api.dart';
import 'api_logger.dart';
import 'bloc_logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    printEmojis: false,
    printTime: true,
  ),
);

void setupLogging(bool enable) {
  if (!enable) return;
  EquatableConfig.stringify = true;
  Bloc.observer = BlocLogger();
  ApiClient.observer = ApiLogger();
}
