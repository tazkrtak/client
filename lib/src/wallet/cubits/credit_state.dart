part of 'credit_cubit.dart';

abstract class CreditState extends Equatable {}

class CreditLoading extends CreditState {
  @override
  List<Object> get props => [];
}

class CreditSuccess extends CreditState {
  final double balance;

  CreditSuccess(this.balance);

  @override
  List<Object> get props => [balance];
}

class CreditError extends CreditState {
  final String? message;

  CreditError([this.message]);

  @override
  List<Object?> get props => [message];
}
