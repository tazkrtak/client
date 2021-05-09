import 'package:dio/dio.dart';

import '../../../api/api.dart';
import '../../../common/cubits/form_cubit/base_form_cubit.dart';
import '../../../services/locator.dart';
import '../models/models.dart';
import 'register_inputs.dart';

class RegisterCubit extends BaseFormCubit<RegisterInputs, User> {
  RegisterCubit() : super(const RegisterInputs());

  void updateFullName(FullName fullName) => updateInputs(
        state.inputs.copyWith(
          fullName: fullName,
        ),
      );

  void updatePhoneNumber(PhoneNumber phoneNumber) => updateInputs(
        state.inputs.copyWith(
          phoneNumber: phoneNumber,
        ),
      );

  void updateEmail(Email email) => updateInputs(
        state.inputs.copyWith(
          email: email,
        ),
      );

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

  void updateTermsAndConditions(TermsAndConditions termsAndConditions) =>
      updateInputs(
        state.inputs.copyWith(
          termsAndConditions: termsAndConditions,
        ),
      );

  @override
  Future<void> submitForm() async {
    if (!canSubmit) return;
    emitInProgress();

    try {
      final user = await _register(state.inputs);
      emitSuccess(user);
    } on DioError catch (dioError) {
      final e = dioError.error;
      if (e is FieldsValidationException) {
        final inputs = state.inputs.copyWith(
          fullName: state.inputs.fullName.copyWithExternalError(
            e.errors['full_name'],
          ),
          phoneNumber: state.inputs.phoneNumber.copyWithExternalError(
            e.errors['phoneNumber'],
          ),
          email: state.inputs.email.copyWithExternalError(
            e.errors['email'],
          ),
          nationalId: state.inputs.nationalId.copyWithExternalError(
            e.errors['national_id'],
          ),
          password: state.inputs.password.copyWithExternalError(
            e.errors['password'],
          ),
        );
        emitInvalid(inputs);
      } else if (e is ServerException) {
        emitFailure(e.message);
      } else {
        emitFailure();
      }
    }
  }

  Future<User> _register(RegisterInputs inputs) async {
    final service = locator.get<UserService>();
    final body = RegisterBody(
      fullName: inputs.fullName.value,
      phoneNumber: inputs.phoneNumber.value,
      email: inputs.email.value,
      nationalId: inputs.nationalId.value,
      password: inputs.password.value,
    );

    return service.register(body);
  }
}
