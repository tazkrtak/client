import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

abstract class ExternalFormzInput<T, E> extends FormzInput<T, E>
    with EquatableMixin {
  final String? externalError;

  const ExternalFormzInput.pure(T value)
      : externalError = null,
        super.pure(value);

  const ExternalFormzInput.dirty(T value, this.externalError)
      : super.dirty(value);

  ExternalFormzInput copyWithExternalError(String? externalError);

  @override
  bool get valid => error == null && externalError == null;

  @override
  List<Object?> get props => [value, pure, externalError];
}
