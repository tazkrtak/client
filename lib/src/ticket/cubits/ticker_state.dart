part of 'ticker_cubit.dart';

class TickerState extends Equatable {
  final int count;
  final bool finished;

  const TickerState(this.count, this.finished);

  @override
  List<Object> get props => [count, finished];
}
