import 'package:formz/formz.dart';

import '../../../common/forms/formz_inputs.dart';
import '../models/models.dart';

class RegisterInputs extends FormzInputs {
  final FullName fullName;
  final PhoneNumber phoneNumber;
  final Email email;
  final NationalId nationalId;
  final Password password;
  final TermsAndConditions termsAndConditions;

  const RegisterInputs({
    this.fullName = const FullName.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.email = const Email.pure(),
    this.nationalId = const NationalId.pure(),
    this.password = const Password.pure(),
    this.termsAndConditions = const TermsAndConditions.pure(),
  });

  RegisterInputs copyWith({
    FullName? fullName,
    PhoneNumber? phoneNumber,
    Email? email,
    NationalId? nationalId,
    Password? password,
    TermsAndConditions? termsAndConditions,
  }) {
    return RegisterInputs(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      nationalId: nationalId ?? this.nationalId,
      password: password ?? this.password,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
    );
  }

  @override
  List<FormzInput> get inputs => [
        fullName,
        phoneNumber,
        email,
        nationalId,
        password,
        termsAndConditions,
      ];
}
