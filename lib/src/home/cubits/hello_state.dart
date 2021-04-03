part of 'hello_cubit.dart';

abstract class HelloState extends Equatable {
  const HelloState();

  @override
  List<Object> get props => [];
}

class HelloLoading extends HelloState {}

class HelloFailure extends HelloState {
  final String error;

  const HelloFailure(this.error);

  @override
  List<Object> get props => [error];
}

class HelloSuccess extends HelloState {
  final String message;

  const HelloSuccess(this.message);

  @override
  List<Object> get props => [message];
}
