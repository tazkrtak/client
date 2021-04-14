import 'dart:convert';

import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final String userId;
  final String totp;
  final int quantity;
  final double price;

  String get value => '$userId:$totp:$quantity:$price';
  String get encodedValue => base64Encode(utf8.encode(value));

  const Ticket({
    required this.userId,
    required this.totp,
    required this.quantity,
    required this.price,
  });

  Ticket copyWith({
    String? userId,
    String? totp,
    int? quantity,
    double? price,
  }) =>
      Ticket(
        userId: userId ?? this.userId,
        totp: totp ?? this.totp,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
      );

  @override
  List<Object> get props => [userId, totp, quantity, price];
}
