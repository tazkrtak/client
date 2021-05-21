import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../api/api.dart';
import '../../../../services/locator.dart';

part 'transactions_summary_state.dart';

class TransactionsSummaryCubit extends Cubit<TransactionsSummaryState> {
  TransactionsSummaryCubit() : super(TransactionsSummaryLoading());

  Future<void> getSummary(DateFilter filter) async {
    final service = locator.get<TransactionsService>();

    emit(TransactionsSummaryLoading());
    try {
      final result = await service.getSummary(filter);
      emit(TransactionsSummarySuccess(
        spent: result.spent,
        recharged: result.recharged,
      ));
    } on DioError catch (dioError) {
      final e = dioError.error;
      if (e is ServerException) {
        emit(TransactionsSummaryError(e.message));
      }
    } catch (e) {
      emit(TransactionsSummaryError());
    }
  }
}
