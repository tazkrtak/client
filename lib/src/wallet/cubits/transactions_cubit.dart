import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../api/api.dart';
import '../../../services/locator.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final int pageSize;

  TransactionsCubit({
    this.pageSize = 10,
  }) : super(TransactionsLoading());

  void refresh() {
    emit(TransactionsRefresh());
  }

  Future<void> fetch(int pageKey, DateFilter filter) async {
    final service = locator.get<TransactionsService>();

    try {
      final body = BasePaginatedQuery<DateFilter>(
        page: pageKey,
        pageSize: pageSize,
        filter: filter,
      );

      final page = await service.get(body);
      emit(
        TransactionSuccess(
          pageSize: page.pageSize,
          pageKey: page.page,
          isLast: page.isLast,
          total: page.total,
          transactions: page.items,
          filter: filter,
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
}
