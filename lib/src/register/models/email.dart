import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../../common/forms/external_formz_input.dart';
import '../../../l10n/tr.dart';

enum EmailError { empty, format, server }

class Email extends ExternalFormzInput<String, EmailError> {
  const Email.pure() : super.pure('');

  const Email.dirty(String value, [String? externalError])
      : super.dirty(value, externalError);

  @override
  EmailError? validator(String value) {
    if (value.isEmpty == true) return EmailError.empty;
    if (!isEmail(value)) return EmailError.format;
    if (externalError != null) return EmailError.server;

    return null;
  }

  @override
  Email copyWithExternalError(String? externalError) {
    return externalError != null ? Email.dirty(value, externalError) : this;
  }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;
    switch (error) {
      case EmailError.empty:
        return tr(context).error_required;
      case EmailError.format:
        return tr(context).register_emailFormatError;
      case EmailError.server:
        return externalError;
      default:
        return tr(context).register_emailError;
    }
  }
}
