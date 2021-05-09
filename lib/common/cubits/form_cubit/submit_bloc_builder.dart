import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_form_cubit.dart';

class SubmitBlocBuilder<C extends BaseFormCubit>
    extends BlocBuilder<C, BaseFormState> {
  const SubmitBlocBuilder({
    required BlocWidgetBuilder<BaseFormState> builder,
    required BlocBuilderCondition<BaseFormState> buildWhen,
  }) : super(
          builder: builder,
          buildWhen: buildWhen,
        );
}
