import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable(createFactory: false)
class Ticket extends Equatable {
  final String userId;
  final String totp;
  final String userKey;
  final int quantity;
  final double price;

  String get value => _toJsonString();
  String get encodedValue => base64Encode(utf8.encode(value));

  const Ticket({
    required this.userId,
    required this.userKey,
    required this.totp,
    required this.quantity,
    required this.price,
  });

  Ticket copyWith({
    String? userId,
    String? userKey,
    String? totp,
    int? quantity,
    double? price,
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

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  String _toJsonString() {
    return const JsonEncoder.withIndent(null).convert(toJson());
  }
}
