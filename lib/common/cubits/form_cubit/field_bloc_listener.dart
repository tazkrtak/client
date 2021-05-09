import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../forms/forms.dart';
import 'base_form_cubit.dart';

class FieldBlocListener<C extends BaseFormCubit<I, O>, I extends FormzInputs, O>
    extends BlocListener<C, BaseFormState<I, O>> {
  const FieldBlocListener({
    required BlocWidgetListener<BaseFormState<I, O>> listener,
    required Widget child,
  }) : super(
          listener: listener,
          child: child,
        );
}
