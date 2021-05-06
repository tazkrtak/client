import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

// import '../../../common/forms/external_formz_input.dart';

enum PhoneNumberError { empty, short, invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberError> {
  const PhoneNumber.pure() : super.pure('');

  const PhoneNumber.dirty(String value) : super.dirty(value);

  @override
  PhoneNumberError? validator(String value) {
    if (value.isEmpty == true) return PhoneNumberError.empty;
    if (!isLength(value, 13)) return PhoneNumberError.short;
    if (!matches(value, r'\+[0-9]{1}[0-9]{11}'))
      return PhoneNumberError.invalid;
  }

  // PhoneNumber copyWithExternalError(ExternalError<PhoneNumberError> error) {
  //   return error.isValid ? PhoneNumber.dirty(value, error) : this;
  // }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;

    switch (error) {
      case PhoneNumberError.empty:
        return "tr(context).error_required";
      case PhoneNumberError.short:
        return "tr(context).register_phoneNumberLengthError";
      case PhoneNumberError.invalid:
        return "tr(context).register_phoneNumberInvalidError";
      default:
        return "tr(context).register_phoneNumberError";
    }
  }
}
