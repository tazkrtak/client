import 'package:equatable/equatable.dart';

class FormResult<T> extends Equatable {
  final T? value;
  final String? error;

  const FormResult.unknown()
      : value = null,
        error = null;

  const FormResult.success(this.value) : error = null;

  const FormResult.failure(this.error) : value = null;

  @override
  List<Object?> get props => [value, error];
}
