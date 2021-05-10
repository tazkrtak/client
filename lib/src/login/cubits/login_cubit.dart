import 'package:dio/dio.dart';

import '../../../api/api.dart';
import '../../../common/cubits/form_cubit/form_cubit.dart';
import '../../../services/locator.dart';
import '../../register/models/models.dart';
import 'login_inputs.dart';

class LoginCubit extends BaseFormCubit<LoginInputs, User> {
  LoginCubit() : super(const LoginInputs());

  void updateNationalId(NationalId nationalId) => updateInputs(
        state.inputs.copyWith(
          nationalId: nationalId,
        ),
      );

  void updatePassword(Password password) => updateInputs(
        state.inputs.copyWith(
          password: password,
        ),
      );

  @override
  Future<void> submitForm() async {
    if (!canSubmit) return;
    emitInProgress();

    try {
      final loggedInUser = await _login(state.inputs);
      emitSuccess(loggedInUser);
    } on DioError catch (dioError) {
      final e = dioError.error;
      if (e is FieldsValidationException) {
        final inputs = state.inputs.copyWith(
          nationalId: state.inputs.nationalId
              .copyWithExternalError(e.errors['national_id']),
          password:
              state.inputs.password.copyWithExternalError(e.errors['password']),
        );
        emitInvalid(inputs);
      } else if (e is ServerException) {
        emitFailure(e.message);
      } else {
        emitFailure();
      }
    }
  }

  Future<User> _login(LoginInputs inputs) async {
    final service = locator.get<UserService>();
    final body = LoginBody(
      nationalId: inputs.nationalId.value,
      password: inputs.password.value,
    );

    return service.login(body);
  }
}
