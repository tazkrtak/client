import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final String id;
  final String fullName;
  final String secret;
  final String email;
  final String key;
  final String token;
  final String phoneNumber;
  final String nationalId;

  const User({
    required this.id,
    required this.fullName,
    required this.secret,
    required this.email,
    required this.key,
    required this.token,
    required this.phoneNumber,
    required this.nationalId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
