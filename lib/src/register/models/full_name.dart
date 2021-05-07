import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

import '../../../l10n/tr.dart';

// import '../../../common/forms/external_formz_input.dart';

enum FullNameError { empty, short }

class FullName extends FormzInput<String, FullNameError> {
  const FullName.pure() : super.pure('');

  const FullName.dirty(String value) : super.dirty(value);

  @override
  FullNameError? validator(String value) {
    if (value.isEmpty == true) return FullNameError.empty;
    if (!isLength(value, 4)) return FullNameError.short;
  }

  // FullName copyWithExternalError(ExternalError<FullNameError> error) {
  //   return error.isValid ? FullName.dirty(value, error) : this;
  // }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;

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
