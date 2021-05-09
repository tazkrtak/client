import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../../common/forms/external_formz_input.dart';
import '../../../l10n/tr.dart';

enum PhoneNumberError { empty, invalid }

class PhoneNumber extends ExternalFormzInput<String, PhoneNumberError> {
  // Egyptian phone number format
  // https://en.wikipedia.org/wiki/Telephone_numbers_in_Egypt
  static const kMaskFormat = '+2 #### #### ###';

  const PhoneNumber.pure() : super.pure('');

  const PhoneNumber.dirty(String value, [String? externalError])
      : super.dirty(value, externalError);

  @override
  PhoneNumberError? validator(String value) {
    final phoneVal = value.replaceAll(' ', '');
    if (phoneVal.isEmpty) return PhoneNumberError.empty;
    if (!matches(phoneVal, r'\+20[0-9]{10}')) return PhoneNumberError.invalid;

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
      case PhoneNumberError.invalid:
        return tr(context).register_phoneNumberInvalidError;
      default:
        return tr(context).register_phoneNumberError;
    }
  }
}
