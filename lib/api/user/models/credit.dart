import 'package:json_annotation/json_annotation.dart';

part 'credit.g.dart';

@JsonSerializable(createToJson: false)
class Credit {
  final double balance;

  Credit(this.balance);

  factory Credit.fromJson(Map<String, dynamic> json) => _$CreditFromJson(json);
}
