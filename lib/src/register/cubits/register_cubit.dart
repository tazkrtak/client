import '../../../api/error/exceptions/exceptions.dart';
// import 'package:tazkrtak/common/forms/external_formz_input.dart';

import '../../../api/user/models/user.dart';
import '../../../api/user/user_service.dart';
import '../../../common/cubits/form_cubit/form_cubit.dart';
import '../../../services/locator.dart';
import '../models/models.dart';
import 'register_inputs.dart';

class RegisterCubit extends FormCubit<RegisterInputs, User> {
  RegisterCubit() : super(const RegisterInputs());

  void updateNationalId(NationalId nationalId) => updateInputs(
        state.inputs!.copyWith(
          nationalId: nationalId,
        ),
      );

  void updateEmail(Email email) => updateInputs(
        state.inputs!.copyWith(
          email: email,
        ),
      );

  void updatePhoneNumber(PhoneNumber phoneNumber) => updateInputs(
        state.inputs!.copyWith(
          phoneNumber: phoneNumber,
        ),
      );

  void updateFullName(FullName fullName) => updateInputs(
        state.inputs!.copyWith(
          fullName: fullName,
        ),
      );

  void updatePassword(Password password) => updateInputs(
        state.inputs!.copyWith(
          password: password,
        ),
      );

  Future<User> _register(RegisterInputs inputs) async {
    final service = locator.get<UserService>();
    final registeredUser = await service.register({
      'nationalId': inputs.nationalId.value,
      'email': inputs.email.value,
      'phoneNumber': inputs.phoneNumber.value,
      'fullName': inputs.fullName.value,
      'password': inputs.password.value,
    });
    return registeredUser;
  }

  @override
  Future<void> submitForm() async {
    if (!canSubmit) return;
    emitInProgress();

    try {
      final registeredUser = await _register(state.inputs!);
      emitSuccess(registeredUser);
    }
//      on ServerException catch (e) {
//       emitFailure(error: e.message);
//       // TODO: Check error types
//       // emitFailure(inputs: state.inputs.copyWith(password: state.inputs.password.copyWiExternal...(message))
// // ) : e.toString());
//     }
    on FieldsValidationException catch (e) {
      e.errors.forEach((field, error) {
        print(field);
        // emitFailure();
        // switch (field) {
        //   case "national_id":
        //     emitFailure(
        //         inputs: state.inputs.copyWith(
        //             // nationalId: state.inputs.nationalId.copyWithExternalError(error as ExternalError<NationalId>)
        //             ),
        //         error: '');
        //     break;
        //   case "email":
        //     emitFailure(
        //         inputs: state.inputs.copyWith(
        //             // email: state.inputs.email.copyWithExternalError(error))
        //             ),
        //         error: '');
        //     break;
        //   case "phone_number":
        //     emitFailure(
        //         inputs: state.inputs.copyWith(
        //             // phoneNumber: state.inputs.phoneNumber.copyWithExternalError(error)
        //             ),
        //         error: '');
        //     break;
        //   case "full_name":
        //     emitFailure(
        //         inputs: state.inputs.copyWith(
        //             // fullName: state.inputs.fullName.copyWithExternalError(error)
        //             ),
        //         error: '');
        //     break;
        //   case "password":
        //     emitFailure(
        //         inputs: state.inputs.copyWith(
        //             // password:state.inputs.password.copyWithExternalError(error)
        //             ),
        //         error: '');
        //     break;
        //   default:
        // }
      });
    } catch (e) {}
  }
}
