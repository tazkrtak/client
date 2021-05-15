import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../api/transactions/transactions_service_mock.dart';
import 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final int pageSize;

  TransactionsCubit({this.pageSize = 5}) : super(TransactionsLoading());
  final service = TransactionsServiceMock();

  Future<void> fetch(int pageKey) async {
    emit(TransactionsLoading());
    try {
      final page = await service.fetch(pageKey, pageSize);
      emit(TransactionSuccess(
        pageSize: pageSize,
        pageKey: page.pageKey,
        transactions: page.data,
      ));
    } on DioError {
      emit(TransactionsError(null));
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }

  void refresh() {
    emit(TransactionsRefresh());
  }
}
