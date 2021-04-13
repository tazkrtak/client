import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../util/totp.dart';

part 'ticker_state.dart';

class TickerCubit extends Cubit<TickerState> {
  late final _Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  TickerCubit() : super(TickerState(Totp.expiresIn, false)) {
    _ticker = _Ticker();
  }

  void start(int expiresIn) {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(expiresIn).listen((duration) {
      emit(TickerState(duration, duration == 0));
    });
  }

  @override
  void onChange(Change<TickerState> change) {
    super.onChange(change);
    final TickerState state = change.nextState;
    if (state.finished) {
      start(Totp.interval);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}

class _Ticker {
  Stream<int> tick(int ticks) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
