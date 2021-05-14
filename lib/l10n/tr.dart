import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

/// Shorthand to translate strings
AppLocalizations tr(BuildContext context) {
  return AppLocalizations.of(context)!;
}

/// Shorthand to translate numbers
String trNumber(BuildContext context, num number) {
  final locale = Localizations.localeOf(context);

  // We need to concatenate an Eastern Arab country code to
  // the 'ar' language, if no country code is provided, to display
  // Eastern Arabic numerals (٩ ٨ ٧ ٦ ٥ ٤ ٣ ٢ ١ ٠)
  // Source: https://en.wikipedia.org/wiki/List_of_numeral_systems
  final localeName = '$locale' == 'ar' ? '${locale}_EG' : '$locale';

  final formatter = NumberFormat.decimalPattern(localeName);
  return formatter.format(number);
}
