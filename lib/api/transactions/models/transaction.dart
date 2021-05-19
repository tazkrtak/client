import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class Transaction {
  final String id;
  final double amount;
  final DateTime createdAt;
  final String title;

  Transaction({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.title,
  });

  //TODO: Remove casting when this issue is fixed
  // https://github.com/trevorwang/retrofit.dart/issues/330
  factory Transaction.fromJson(Object? json) =>
      // ignore: cast_nullable_to_non_nullable
      _$TransactionFromJson(json as Map<String, dynamic>);
}
