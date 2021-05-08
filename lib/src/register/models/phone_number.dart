import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../../common/forms/external_formz_input.dart';
import '../../../l10n/tr.dart';

enum PhoneNumberError { empty, short, invalid }

class PhoneNumber extends ExternalFormzInput<String, PhoneNumberError> {
  const PhoneNumber.pure() : super.pure('');

  const PhoneNumber.dirty(String value, [String? externalError])
      : super.dirty(value, externalError);

  @override
  PhoneNumberError? validator(String value) {
    if (value.isEmpty == true) return PhoneNumberError.empty;
    if (!isLength(value, 13)) return PhoneNumberError.short;
    if (!matches(value, r'\+2[0-9]{11}')) return PhoneNumberError.invalid;

    return null;
  }

  @override
  PhoneNumber copyWithExternalError(String? externalError) {
    return externalError != null
        ? PhoneNumber.dirty(value, externalError)
        : this;
  }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;
    if (externalError != null) return externalError;
    
    switch (error) {
      case PhoneNumberError.empty:
        return tr(context).error_required;
      case PhoneNumberError.short:
        return tr(context).register_phoneNumberLengthError;
      case PhoneNumberError.invalid:
        return tr(context).register_phoneNumberInvalidError;
      default:
        return tr(context).register_phoneNumberError;
    }
  }
}
