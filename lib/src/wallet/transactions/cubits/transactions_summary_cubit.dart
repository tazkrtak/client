import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../api/transactions/transactions_service_mock.dart';

part 'transactions_summary_state.dart';

class TransactionsSummaryCubit extends Cubit<TransactionsSummaryState> {
  final service = TransactionsServiceMock();

  TransactionsSummaryCubit() : super(TransactionsSummaryLoading());

  Future<void> getSummary() async {
    emit(TransactionsSummaryLoading());
    try {
      final result = await service.getSummary();
      emit(TransactionsSummarySuccess(
        spent: result.spent,
        recharged: result.recharged,
        balance: result.balance,
      ));
    } on DioError {
      emit(TransactionsSummaryError(null));
    } catch (e) {
      emit(TransactionsSummaryError(e.toString()));
    }
  }
}
