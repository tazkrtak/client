import 'package:formz/formz.dart';

import '../../../common/forms/formz_inputs.dart';
import '../models/models.dart';

class RegisterInputs extends FormzInputs {
  final NationalId nationalId;
  final Email email;
  final PhoneNumber phoneNumber;
  final FullName fullName;
  final Password password;

  const RegisterInputs({
    this.nationalId = const NationalId.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.fullName = const FullName.pure(),
    this.password = const Password.pure(),
  });

  RegisterInputs copyWith({
    NationalId? nationalId,
    Email? email,
    PhoneNumber? phoneNumber,
    FullName? fullName,
    Password? password,
  }) {
    return RegisterInputs(
      nationalId: nationalId ?? this.nationalId,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
    );
  }

  @override
  List<FormzInput> get inputs => [
        nationalId,
        email,
        phoneNumber,
        fullName,
        password,
      ];
}
