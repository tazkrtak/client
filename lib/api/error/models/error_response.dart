import 'package:json_annotation/json_annotation.dart';

import 'validation_error.dart';

part 'error_response.g.dart';

@JsonSerializable(createToJson: false)
class ErrorResponse {
  final int statusCode;
  final String message;
  final String? error;
  final List<FieldValidationError>? validationErrors;

  const ErrorResponse({
    required this.statusCode,
    required this.message,
    this.validationErrors,
    this.error,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}
