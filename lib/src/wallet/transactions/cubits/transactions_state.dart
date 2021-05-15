import 'package:equatable/equatable.dart';

import '../models/transaction.dart';

abstract class TransactionsState extends Equatable {}

class TransactionsLoading extends TransactionsState {
  @override
  List<Object?> get props => [];
}

class TransactionSuccess extends TransactionsState {
  final List<Transaction> transactions;
  final int pageKey;
  final int pageSize;

  bool get isLastPage => transactions.length < 5;

  int? get nextPageKey => isLastPage ? null : pageKey + 1;

  TransactionSuccess({
    required this.pageSize,
    required this.transactions,
    required this.pageKey,
  });

  @override
  List<Object?> get props => [transactions, pageKey];
}

class TransactionsError extends TransactionsState {
  final String? message;

  TransactionsError(this.message);

  @override
  List<Object?> get props => [message];
}

class TransactionsRefresh extends TransactionsState {
  @override
  List<Object?> get props => [];
}
