import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Shorthand to translate strings
AppLocalizations tr(BuildContext context) {
  return AppLocalizations.of(context)!;
}

String trNumber(num number) {
  return NumberFormat.decimalPattern(Platform.localeName).format(number);
}
