import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../forms/forms.dart';

part 'base_form_state.dart';

abstract class BaseFormCubit<TInputs extends FormzInputs, TResult>
    extends Cubit<BaseFormState<TInputs, TResult>> {
  BaseFormCubit(TInputs inputs) : super(BaseFormState(inputs: inputs));

  bool get canSubmit => state.status.isValidated;

  void updateInputs(TInputs inputs) {
    emit(state.copyWith(inputs: inputs));
  }

  Future<void> submitForm();

  void emitInProgress() {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
  }

  void emitSuccess(TResult result) {
    emit(
      state.copyWith(
          status: FormzStatus.submissionSuccess,
          result: FormResult<TResult>.success(result)),
    );
  }

  void emitFailure([String? error]) {
    emit(
      state.copyWith(
          status: FormzStatus.submissionFailure,
          result: FormResult<TResult>.failure(error)),
    );
  }

  void emitInvalid(TInputs inputs) {
    emit(state.copyWith(
      status: FormzStatus.invalid,
      inputs: inputs,
    ));
  }
}
