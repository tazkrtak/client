import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../l10n/tr.dart';

enum AgreeOnTermsAndConditionsError { notChecked }

class AgreeOnTermsAndConditions
    extends FormzInput<bool, AgreeOnTermsAndConditionsError> {
  const AgreeOnTermsAndConditions.pure() : super.pure(false);

  const AgreeOnTermsAndConditions.dirty(bool value) : super.dirty(value);

  @override
  AgreeOnTermsAndConditionsError? validator(bool value) {
    return !value ? AgreeOnTermsAndConditionsError.notChecked : null;
  }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;
    return tr(context).error_required;
  }
}
