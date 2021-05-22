import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../api/api.dart';
import '../../../services/locator.dart';

part 'credit_state.dart';

class CreditCubit extends Cubit<CreditState> {
  CreditCubit() : super(CreditLoading());

  Future<void> recharge(double amount) async {
    try {
      final service = locator.get<UserService>();
      final transaction = await service.recharge(
        // TODO: Remove default values after adding recharge screen
        const RechargeBody(
          cardNumber: '5555555555554444',
          expiryYear: '22',
          expiryMonth: '05',
          cvv: '123',
          nameOnCard: 'Lorem Ipsum',
          rechargeAmount: 50,
        ),
      );

      final currentState = state;
      if (currentState is CreditSuccess) {
        emit(CreditSuccess(currentState.balance + transaction.amount));
      }
    } on DioError catch (dioError) {
      final e = dioError.error;
      if (e is ServerException) {
        emit(CreditError(e.message));
      }
    } catch (e) {
      emit(CreditError());
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
