import 'package:formz/formz.dart';

import '../../../common/forms/formz_inputs.dart';
import '../../register/models/models.dart';

class LoginInputs extends FormzInputs {
  final NationalId nationalId;
  final Password password;

  const LoginInputs({
    this.nationalId = const NationalId.pure(),
    this.password = const Password.pure(),
  });

  LoginInputs copyWith({
    NationalId? nationalId,
    Password? password,
  }) {
    return LoginInputs(
      nationalId: nationalId ?? this.nationalId,
      password: password ?? this.password,
    );
  }

  @override
  List<FormzInput> get inputs => [
        nationalId,
        password,
      ];
}
