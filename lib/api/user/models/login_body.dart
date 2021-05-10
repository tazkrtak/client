import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class LoginBody {
  final String nationalId;
  final String password;

  const LoginBody({
    required this.nationalId,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
}
