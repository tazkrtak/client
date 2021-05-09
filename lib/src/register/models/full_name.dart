import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../../common/forms/external_formz_input.dart';
import '../../../l10n/tr.dart';

enum FullNameError { empty, short }

class FullName extends ExternalFormzInput<String, FullNameError> {
  const FullName.pure() : super.pure('');

  const FullName.dirty(String value, [String? externalError])
      : super.dirty(value, externalError);

  @override
  FullNameError? validator(String value) {
    if (value.isEmpty) return FullNameError.empty;
    if (!isLength(value, 4)) return FullNameError.short;

    return null;
  }

  @override
  FullName copyWithExternalError(String? externalError) {
    return externalError != null ? FullName.dirty(value, externalError) : this;
  }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;
    if (externalError != null) return externalError;

    switch (error) {
      case FullNameError.empty:
        return tr(context).error_required;
      case FullNameError.short:
        return tr(context).register_fullNameLengthError;
      default:
        return tr(context).register_fullNameError;
    }
  }
}
