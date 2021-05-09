import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../l10n/tr.dart';

enum TermsAndConditionsError { notChecked }

class TermsAndConditions extends FormzInput<bool, TermsAndConditionsError> {
  const TermsAndConditions.pure() : super.pure(false);

  const TermsAndConditions.dirty(bool value) : super.dirty(value);

  @override
  TermsAndConditionsError? validator(bool value) {
    return !value ? TermsAndConditionsError.notChecked : null;
  }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;
    return tr(context).error_required;
  }
}
