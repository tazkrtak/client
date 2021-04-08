import 'package:flutter/material.dart';

import 'services/locator.dart';
import 'src/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerServices();
  runApp(App());
}
