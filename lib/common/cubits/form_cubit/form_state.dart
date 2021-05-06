part of 'form_cubit.dart';

class FormState<TInputs extends FormzInputs, TResult> extends Equatable {
  final TInputs? inputs;
  final FormResult<TResult>? result;
  final FormzStatus status;

  const FormState({
    required this.inputs,
    this.result,
    required this.status,
  });

  FormState<TInputs, TResult> copyWith({
    TInputs? inputs,
    FormResult<TResult>? result,
    FormzStatus? status,
  }) {
    return FormState(
      inputs: inputs ?? this.inputs,
      result: result ?? this.result,
      status: status ?? this.status,
    );
  }

  @override
  List<dynamic> get props => [inputs, result, status];
}
