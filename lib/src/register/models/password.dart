import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum PasswordError {
  empty,
  short,
  missingLowerCaseLetter,
  missingUpperCaseLetter,
  missingDigit,
  missingSymbol,
}

class Password extends FormzInput<String, PasswordError> {
  const Password.pure() : super.pure('');

  const Password.dirty(String value) : super.dirty(value);

  @override
  PasswordError? validator(String value) {
    if (value.isEmpty == true) return PasswordError.empty;
    if (!isLength(value, 6)) return PasswordError.short;
    if (!matches(value, '[a-z]')) return PasswordError.missingLowerCaseLetter;
    if (!matches(value, '[A-Z]')) return PasswordError.missingUpperCaseLetter;
    if (!matches(value, r'\d')) return PasswordError.missingDigit;
    if (!matches(value, r'[@$!%#?&]')) return PasswordError.missingSymbol;
    return null;
  }

  // Password copyWithExternalError(ExternalError<PasswordError> error) {
  //   return error.isValid ? Password.dirty(value, error) : this;
  // }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;

    switch (error) {
      case PasswordError.empty:
        return "tr(context).error_required";
      case PasswordError.short:
        return "tr(context).login_passwordLengthError";
      case PasswordError.missingLowerCaseLetter:
        return "tr(context).login_passwordLowercaseError";
      case PasswordError.missingUpperCaseLetter:
        return "tr(context).login_passwordUppercaseError";
      case PasswordError.missingDigit:
        return "tr(context).login_passwordDigitError";
      case PasswordError.missingSymbol:
        return "tr(context).login_passwordSymbolError";
      default:
        return "tr(context).login_passwordError";
    }
  }
}
