import 'package:dio/dio.dart';

import '../../../api/api.dart';
import '../../../api/error/exceptions/exceptions.dart';
import '../../../api/user/models/user.dart';
import '../../../api/user/user_service.dart';
import '../../../common/cubits/form_cubit/form_cubit.dart';
import '../../../services/locator.dart';
import '../models/agree_on_terms_and_conditions.dart';
import '../models/models.dart';
import 'register_inputs.dart';

class RegisterCubit extends FormCubit<RegisterInputs, User> {
  RegisterCubit() : super(const RegisterInputs());

  void updateNationalId(NationalId nationalId) => updateInputs(
        state.inputs.copyWith(
          nationalId: nationalId,
        ),
      );

  void updateEmail(Email email) => updateInputs(
        state.inputs.copyWith(
          email: email,
        ),
      );

  void updatePhoneNumber(PhoneNumber phoneNumber) => updateInputs(
        state.inputs.copyWith(
          phoneNumber: phoneNumber,
        ),
      );

  void updateFullName(FullName fullName) => updateInputs(
        state.inputs.copyWith(
          fullName: fullName,
        ),
      );

  void updatePassword(Password password) => updateInputs(
        state.inputs.copyWith(
          password: password,
        ),
      );

  void updateAgreeOnTermsAndConditions(
          AgreeOnTermsAndConditions agreeOnTermsAndConditions) =>
      updateInputs(
        state.inputs.copyWith(
          agreeOnTermsAndConditions: agreeOnTermsAndConditions,
        ),
      );

  @override
  Future<void> submitForm() async {
    if (!canSubmit) return;
    emitInProgress();

    try {
      final registeredUser = await _register(state.inputs);
      emitSuccess(registeredUser);
    } catch (e) {
      if (e is DioError) {
        if (e.error is FieldsValidationException) {
          final inputsState = state.inputs.copyWith(
            email: state.inputs.email
                .copyWithExternalError(e.error.errors['email'] as String?),
            fullName: state.inputs.fullName
                .copyWithExternalError(e.error.errors['full_name'] as String?),
            nationalId: state.inputs.nationalId.copyWithExternalError(
                e.error.errors['national_id'] as String?),
            password: state.inputs.password
                .copyWithExternalError(e.error.errors['password'] as String?),
            phoneNumber: state.inputs.phoneNumber.copyWithExternalError(
                e.error.errors['phoneNumber'] as String?),
          );
          emitInvalid(inputsState);
        } else if (e.error is ServerException) {
          emitFailure(e.error.message as String);
        }
      } else {
        emitFailure('Something wrong happened!');
      }
    }
  }
}

Future<User> _register(RegisterInputs inputs) async {
  final service = locator.get<UserService>();
  final body = RegisterBody(
    email: inputs.email.value,
    fullName: inputs.fullName.value,
    nationalId: inputs.nationalId.value,
    password: inputs.password.value,
    phoneNumber: inputs.phoneNumber.value,
  );

  final registeredUser = service.register(body);
  return registeredUser;
}
