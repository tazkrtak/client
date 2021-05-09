import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../../common/forms/external_formz_input.dart';
import '../../../l10n/tr.dart';

enum NationalIdError { empty, short, nonDigit }

class NationalId extends ExternalFormzInput<String, NationalIdError> {
  // Egyptian national id format
  // x - yymmdd - ss - iiig - z
  // https://codereview.stackexchange.com/questions/221899
  static const kMaskFormat = '# ###### ## #### #';

  const NationalId.pure() : super.pure('');

  const NationalId.dirty(String value, [String? externalError])
      : super.dirty(value, externalError);

  @override
  NationalIdError? validator(String value) {
    if (value.isEmpty == true) return NationalIdError.empty;
    if (!isLength(value, 14)) return NationalIdError.short;
    if (!matches(value, r'\d{14}')) return NationalIdError.nonDigit;

    return null;
  }

  @override
  NationalId copyWithExternalError(String? externalError) {
    return externalError != null
        ? NationalId.dirty(value, externalError)
        : this;
  }

  String? getErrorText(BuildContext context) {
    if (pure || valid) return null;
    if (externalError != null) return externalError;

    switch (error) {
      case NationalIdError.empty:
        return tr(context).error_required;
      case NationalIdError.short:
        return tr(context).register_nationalIdLengthError;
      case NationalIdError.nonDigit:
        return tr(context).register_nationalIdFormatError;
      default:
        return tr(context).register_nationalIdError;
    }
  }
}
