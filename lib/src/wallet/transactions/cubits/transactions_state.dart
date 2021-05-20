import 'package:equatable/equatable.dart';

import '../../../../api/api.dart';

abstract class TransactionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TransactionsRefresh extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsError extends TransactionsState {
  final String? message;

  TransactionsError(this.message);

  @override
  List<Object?> get props => [message];
}

class TransactionSuccess extends TransactionsState {
  final int pageKey;
  final int pageSize;
  final int total;
  final bool isLast;
  final DateFilter filter;
  final List<Transaction> transactions;

  int? get nextPageKey => isLast ? null : pageKey + 1;

  TransactionSuccess({
    required this.pageKey,
    required this.pageSize,
    required this.total,
    required this.isLast,
    required this.filter,
    required this.transactions,
  });

  @override
  List<Object?> get props => [
        pageKey,
        pageSize,
        total,
        isLast,
        filter,
        transactions,
      ];
}
