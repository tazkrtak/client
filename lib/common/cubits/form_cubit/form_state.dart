part of 'form_cubit.dart';

class FormState<TInputs extends FormzInputs, TResult> extends Equatable {
  final TInputs inputs;
  final FormResult<TResult>? result;
  final FormzStatus status;

  const FormState({
    required this.inputs,
    required this.status,
    this.result,
  });

  FormState<TInputs, TResult> copyWith({
    TInputs? inputs,
    FormResult<TResult>? result,
    FormzStatus? status,
  }) {
    return FormState(
      inputs: inputs ?? this.inputs,
      status: status ?? (inputs != null? inputs.validate() : FormzStatus.invalid),
      // do not copy old results because when the state changes,
      // they need to be recomputed.
      result: result ?? FormResult<TResult>.unknown(),
    );
  }

  @override
  List<dynamic> get props => [inputs, result, status];
}
