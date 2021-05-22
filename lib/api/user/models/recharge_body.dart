import 'package:json_annotation/json_annotation.dart';

part 'recharge_body.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class RechargeBody {
  final String cardNumber;
  final String expiryYear;
  final String expiryMonth;
  final String cvv;
  final String nameOnCard;
  final double rechargeAmount;

  const RechargeBody({
    required this.cardNumber,
    required this.expiryYear,
    required this.expiryMonth,
    required this.cvv,
    required this.nameOnCard,
    required this.rechargeAmount,
  });

  Map<String, dynamic> toJson() => _$RechargeBodyToJson(this);
}
