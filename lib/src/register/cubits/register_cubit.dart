import '../../../api/api.dart';

import '../../../api/error/exceptions/exceptions.dart';

import '../../../api/user/models/user.dart';
import '../../../api/user/user_service.dart';
import '../../../common/cubits/form_cubit/form_cubit.dart';
import '../../../services/locator.dart';
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

  @override
  Future<void> submitForm() async {
    if (!canSubmit) return;
    emitInProgress();

    try {
      final registeredUser = await _register(state.inputs);
      emitSuccess(registeredUser);
    } on ServerException catch (e) {
      emitFailure(e.message);
    } on FieldsValidationException catch (e) {
      // TODO: emitInvalid with inputs with external error
      print(e.errors.keys);
    } catch (e) {
      // TODO: Emit Failure wil no message
    }
  }

  Future<User> _register(RegisterInputs inputs) async {
    final service = locator.get<UserService>();
    final body = RegisterBody(
      email: inputs.email.value,
      fullName: inputs.fullName.value,
      nationalId: inputs.fullName.value,
      password: inputs.password.value,
      phoneNumber: inputs.phoneNumber.value,
    );

    final registeredUser = await service.register(body);
    return registeredUser;
  }
}
