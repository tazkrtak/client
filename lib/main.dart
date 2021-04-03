import 'package:flutter/material.dart';

import 'services/locator.dart';
import 'src/app/app.dart';

void main() {
  registerServices();
  runApp(App());
}
