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

  // TODO: Remove default values after adding recharge screen
  RechargeBody({
    this.cardNumber = '5555555555554444',
    this.expiryYear = '22',
    this.expiryMonth = '05',
    this.cvv = '123',
    this.nameOnCard = 'Lorem Ipsum',
    required this.rechargeAmount,
  });

  Map<String, dynamic> toJson() => _$RechargeBodyToJson(this);
}
