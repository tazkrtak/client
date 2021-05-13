part of 'base_form_cubit.dart';

class BaseFormState<TInputs extends FormzInputs, TResult> extends Equatable {
  final TInputs inputs;
  final FormResult<TResult>? result;
  final FormzStatus status;

  const BaseFormState({
    required this.inputs,
    this.status = FormzStatus.pure,
    this.result,
  });

  BaseFormState<TInputs, TResult> copyWith({
    TInputs? inputs,
    FormResult<TResult>? result,
    FormzStatus? status,
  }) {
    return BaseFormState(
      inputs: inputs ?? this.inputs,
      status:
          status ?? (inputs != null ? inputs.validate() : FormzStatus.invalid),
      // do not copy old results because when the state changes,
      // they need to be recomputed.
      result: result ?? FormResult<TResult>.unknown(),
    );
  }

  @override
  List<dynamic> get props => [inputs, result, status];
}
