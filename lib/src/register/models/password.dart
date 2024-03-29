import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../../common/forms/external_formz_input.dart';
import '../../../l10n/tr.dart';

enum PasswordError {
  empty,
  short,
  missingLowerCaseLetter,
  missingUpperCaseLetter,
  missingDigit,
}

class Password extends ExternalFormzInput<String, PasswordError> {
  const Password.pure() : super.pure('');

  const Password.dirty(String value, [String? externalError])
      : super.dirty(value, externalError);

  @override
  PasswordError? validator(String value) {
    if (value.isEmpty) return PasswordError.empty;
    if (!isLength(value, 8)) return PasswordError.short;
    if (!matches(value, '[a-z]')) return PasswordError.missingLowerCaseLetter;
    if (!matches(value, '[A-Z]')) return PasswordError.missingUpperCaseLetter;
    if (!matches(value, r'\d')) return PasswordError.missingDigit;

    return null;
  }

  @override
  Password copyWithExternalError(String? externalError) {
    return externalError != null ? Password.dirty(value, externalError) : this;
  }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;
    if (externalError != null) return externalError;

    switch (error) {
      case PasswordError.empty:
        return tr(context).error_required;
      case PasswordError.short:
        return tr(context).register_passwordLengthError;
      case PasswordError.missingLowerCaseLetter:
        return tr(context).register_passwordLowercaseError;
      case PasswordError.missingUpperCaseLetter:
        return tr(context).register_passwordUppercaseError;
      case PasswordError.missingDigit:
        return tr(context).register_passwordDigitError;
      default:
        return tr(context).register_passwordError;
    }
  }
}
