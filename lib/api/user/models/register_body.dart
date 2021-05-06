import 'package:json_annotation/json_annotation.dart';

part 'register_body.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class RegisterBody {
  final String fullName;
  final String nationalId;
  final String email;
  final String password;
  final String phoneNumber;

  const RegisterBody({
    required this.fullName,
    required this.nationalId,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);
}
