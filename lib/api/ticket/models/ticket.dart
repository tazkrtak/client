import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable(createFactory: false, ignoreUnannotated: true)
class Ticket extends Equatable {
  @JsonKey()
  final String userId;

  @JsonKey()
  final String totp;

  @JsonKey()
  final String userKey;

  @JsonKey()
  final int quantity;

  @JsonKey()
  final double price;

  double get totalAmount => quantity * price;
  String get value => json.encode(toJson());

  String get encodedValue => base64Encode(utf8.encode(value));

  const Ticket({
    required this.userId,
    required this.userKey,
    required this.totp,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  Ticket copyWith({
    String? userId,
    String? userKey,
    String? totp,
    int? quantity,
    double? price,
    double? totalAmount,
  }) =>
      Ticket(
        userId: userId ?? this.userId,
        userKey: userKey ?? this.userKey,
        totp: totp ?? this.totp,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
      );

  @override
  List<Object> get props => [userId, userKey, totp, quantity, price];
}
