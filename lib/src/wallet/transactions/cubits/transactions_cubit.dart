import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../api/api.dart';
import '../../../../services/locator.dart';
import 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final int pageSize;
  final DateFilter initialFilter;

  DateFilter get filter {
    final currentState = state;
    if (currentState is TransactionsFilterUpdate) {
      return currentState.filter;
    } else if (currentState is TransactionSuccess) {
      return currentState.filter;
    } else {
      return initialFilter;
    }
  }

  TransactionsCubit({
    required this.initialFilter,
    this.pageSize = 10,
  }) : super(TransactionsLoading());

  Future<void> fetch(int pageKey) async {
    final service = locator.get<TransactionsService>();
    final currentFilter = filter;
    emit(TransactionsLoading());
    try {
      final body = BasePaginatedQuery<DateFilter>(
        page: pageKey,
        pageSize: pageSize,
        filter: currentFilter,
      );
      final page = await service.get(body);
      emit(
        TransactionSuccess(
          pageSize: page.pageSize,
          pageKey: page.page,
          isLast: page.isLast,
          total: page.total,
          transactions: page.items,
          filter: currentFilter,
        ),
      );
    } on DioError catch (dioError) {
      final e = dioError.error;
      if (e is ServerException) {
        emit(TransactionsError(e.message));
      }
    } catch (e) {
      emit(TransactionsError(null));
    }
  }

  void refresh() {
    emit(TransactionsRefresh());
  }

  void updateFilter(DateFilter filter) {
    emit(TransactionsFilterUpdate(filter));
  }
}
