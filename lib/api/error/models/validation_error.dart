import 'package:json_annotation/json_annotation.dart';

part 'validation_error.g.dart';

@JsonSerializable(createToJson: false)
class FieldValidationError {
  final String field;
  final String error;

  FieldValidationError({
    required this.field,
    required this.error,
  });

  factory FieldValidationError.fromJson(Map<String, dynamic> json) =>
      _$FieldValidationErrorFromJson(json);
}
