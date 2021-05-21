import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../api/api.dart';
import '../../../services/locator.dart';

part 'credit_state.dart';

class CreditCubit extends Cubit<CreditState> {
  CreditCubit() : super(CreditLoading());

  void incrementBalance(double balance) {
    final currentState = state;
    if (currentState is CreditSuccess) {
      emit(CreditSuccess(currentState.balance + balance));
    }
  }

  Future<void> getBalance() async {
    final service = locator.get<UserService>();

    emit(CreditLoading());
    try {
      final result = await service.getCredit();
      emit(CreditSuccess(result.balance));
    } on DioError catch (dioError) {
      final e = dioError.error;
      if (e is ServerException) {
        emit(CreditError(e.message));
      }
    } catch (e) {
      emit(CreditError());
    }
  }
}
