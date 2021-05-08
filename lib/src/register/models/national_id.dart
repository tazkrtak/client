import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../../common/forms/external_formz_input.dart';
import '../../../l10n/tr.dart';

enum NationalIdError { empty, short, nonDigit, server }

class NationalId extends ExternalFormzInput<String, NationalIdError> {
  const NationalId.pure() : super.pure('');

  const NationalId.dirty(String value, [String? externalError])
      : super.dirty(value, externalError);

  @override
  NationalIdError? validator(String value) {
    if (value.isEmpty == true) return NationalIdError.empty;
    if (!isLength(value, 14)) return NationalIdError.short;
    if (!matches(value, r'\d{14}')) return NationalIdError.nonDigit;
    if (externalError != null) return NationalIdError.server;

    return null;
  }

  @override
  NationalId copyWithExternalError(String? externalError) {
    return externalError != null
        ? NationalId.dirty(value, externalError)
        : this;
  }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;
    switch (error) {
      case NationalIdError.empty:
        return tr(context).error_required;
      case NationalIdError.short:
        return tr(context).register_nationalIdLengthError;
      case NationalIdError.nonDigit:
        return tr(context).register_nationalIdFormatError;
      case NationalIdError.server:
        return externalError;
      default:
        return tr(context).register_nationalIdError;
    }
  }
}
