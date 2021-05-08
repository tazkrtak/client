import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../l10n/tr.dart';

enum AgreeOnTermsAndConditionsError { notChecked }

class AgreeOnTermsAndConditions
    extends FormzInput<String, AgreeOnTermsAndConditionsError> {
  const AgreeOnTermsAndConditions.pure() : super.pure('');

  const AgreeOnTermsAndConditions.dirty(String value) : super.dirty(value);

  @override
  AgreeOnTermsAndConditionsError? validator(String value) {
    if (value == '') return AgreeOnTermsAndConditionsError.notChecked;
  }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;
    return tr(context).error_required;
  }
}
