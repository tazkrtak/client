import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:validators/validators.dart';
import '../../../l10n/tr.dart';
// import '../../../common/forms/external_formz_input.dart';

enum EmailError { empty, format, server }

class Email extends FormzInput<String, EmailError> {
  const Email.pure() : super.pure('');

  const Email.dirty(String value) : super.dirty(value);

  /*const Email.dirty(String value, [ExternalError<EmailError> error])
      : super.dirty(value, error);*/

  @override
  EmailError? validator(String value) {
    if (value.isEmpty == true) return EmailError.empty;
    if (!isEmail(value)) return EmailError.format;
    return null;
  }

  // Email copyWithExternalError(ExternalError<EmailError> error) {
  //   return error.isValid ? Email.dirty(value, error) : this;
  // }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;

    switch (error) {
      case EmailError.empty:
        return tr(context).error_required;
      case EmailError.format:
        return tr(context).register_emailFormatError;
      // case EmailError.server:
      //   return "externalError.details";
      default:
        return tr(context).register_emailError;
    }
  }
}
