class Ticket {
  final String userId;
  final String totp;
  final int quantity;
  final double price;

  Ticket({
    required this.userId,
    required this.totp,
    required this.quantity,
    required this.price,
  });

  Ticket copyWith(
          {String? userId, String? totp, int? quantity, double? price}) =>
      Ticket(
        userId: userId ?? this.userId,
        totp: totp ?? this.totp,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
      );

  String get value => '$userId,$totp,$quantity,$price';
}
