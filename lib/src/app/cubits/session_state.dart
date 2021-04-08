part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class SessionLoading extends SessionState {}

class SessionUnknown extends SessionState {}

class SessionSuccess extends SessionState {
  final User user;

  const SessionSuccess(this.user);

  @override
  List<Object> get props => [user];
}
