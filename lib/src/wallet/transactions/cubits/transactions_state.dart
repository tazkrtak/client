import 'package:equatable/equatable.dart';

import '../../../../api/api.dart';

abstract class TransactionsState extends Equatable {}

class TransactionsLoading extends TransactionsState {
  @override
  List<Object?> get props => [];
}

class TransactionSuccess extends TransactionsState {
  final List<Transaction> transactions;
  final int pageKey;
  final int pageSize;
  final int total;
  final bool isLast;
  final DateFilter filter;

  int? get nextPageKey => isLast ? null : pageKey + 1;

  TransactionSuccess(
      {required this.pageSize,
      required this.transactions,
      required this.pageKey,
      required this.total,
      required this.isLast,
      required this.filter});

  @override
  List<Object?> get props => [
        transactions,
        pageKey,
        pageSize,
        total,
        isLast,
        filter,
      ];
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

class TransactionsFilterUpdate extends TransactionsState {
  final DateFilter filter;

  TransactionsFilterUpdate(this.filter);

  @override
  List<Object?> get props => [filter];
}
