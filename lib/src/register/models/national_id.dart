import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

import '../../../l10n/tr.dart';

enum NationalIdError { empty, short, nonDigit }

class NationalId extends FormzInput<String, NationalIdError> {
  const NationalId.pure() : super.pure('');

  const NationalId.dirty(String value) : super.dirty(value);

  @override
  NationalIdError? validator(String value) {
    if (value.isEmpty == true) return NationalIdError.empty;
    if (!isLength(value, 14)) return NationalIdError.short;
    if (!matches(value, r'\d{14}')) return NationalIdError.nonDigit;
  }

  // NationalId copyWithExternalError(ExternalError<NationalId> error) {
  //   return error.isValid ? NationalId.dirty(value, error) : this;
  // }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;
    switch (error) {
      case NationalIdError.empty:
        return tr(context).error_required;
      case NationalIdError.short:
        return tr(context).register_nationalIdLengthError;
      case NationalIdError.nonDigit:
        return tr(context).register_nationalIdFormatError;
      default:
        return tr(context).register_nationalIdError;
    }
  }
}
