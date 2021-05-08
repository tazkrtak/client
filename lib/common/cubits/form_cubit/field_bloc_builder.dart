import 'package:flutter_bloc/flutter_bloc.dart';
import '../../forms/forms.dart';
import 'base_form_cubit.dart';

class FieldBlocBuilder<C extends BaseFormCubit<I, dynamic>,
    I extends FormzInputs> extends BlocBuilder<C, BaseFormState<I, dynamic>> {
  const FieldBlocBuilder({
    required BlocWidgetBuilder<BaseFormState<I, dynamic>> builder,
    required BlocBuilderCondition<BaseFormState<I, dynamic>> buildWhen,
  }) : super(
          builder: builder,
          buildWhen: buildWhen,
        );
}
