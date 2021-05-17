part of 'transactions_summary_cubit.dart';

abstract class TransactionsSummaryState extends Equatable {}

class TransactionsSummaryLoading extends TransactionsSummaryState {
  @override
  List<Object> get props => [];
}

class TransactionsSummarySuccess extends TransactionsSummaryState {
  final double balance;
  final double recharged;
  final double spent;

  TransactionsSummarySuccess({
    required this.balance,
    required this.recharged,
    required this.spent,
  });

  @override
  List<Object> get props => [balance, recharged, spent];
}

class TransactionsSummaryError extends TransactionsSummaryState {
  final String? message;

  TransactionsSummaryError(this.message);

  @override
  List<Object> get props => [];
}
