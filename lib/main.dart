import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'logging/logging.dart';
import 'services/locator.dart';
import 'src/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLogging(kDebugMode); // TODO: use environment
  await registerServices();
  runApp(App());
}
