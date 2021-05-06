import '../models/models.dart';

class FieldsValidationException implements Exception {
  final Map<String, String> errors;

  FieldsValidationException(List<FieldValidationError> errors)
      : errors = {for (var e in errors) e.field: e.error};
}
