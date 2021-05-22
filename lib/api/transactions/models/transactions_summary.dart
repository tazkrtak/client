import 'package:json_annotation/json_annotation.dart';

part 'transactions_summary.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class TransactionsSummary {
  final double spent;
  final double recharged;

  const TransactionsSummary({
    required this.spent,
    required this.recharged,
  });

  factory TransactionsSummary.fromJson(Map<String, dynamic> json) =>
      _$TransactionsSummaryFromJson(json);
}
