import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../../common/forms/external_formz_input.dart';
import '../../../l10n/tr.dart';

enum EmailError { empty, format }

class Email extends ExternalFormzInput<String, EmailError> {
  const Email.pure() : super.pure('');

  const Email.dirty(String value, [String? externalError])
      : super.dirty(value, externalError);

  @override
  EmailError? validator(String value) {
    if (value.isEmpty) return EmailError.empty;
    if (!isEmail(value)) return EmailError.format;

    return null;
  }

  @override
  Email copyWithExternalError(String? externalError) {
    return externalError != null ? Email.dirty(value, externalError) : this;
  }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;
    if (externalError != null) return externalError;

    switch (error) {
      case EmailError.empty:
        return tr(context).error_required;
      case EmailError.format:
        return tr(context).register_emailFormatError;
      default:
        return tr(context).register_emailError;
    }
  }
}
