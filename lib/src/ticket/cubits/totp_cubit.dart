import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otp/otp.dart';

part 'totp_state.dart';

class TotpCubit extends Cubit<TotpState> {
  static const kInerval = 30;
  static int get _now => DateTime.now().millisecondsSinceEpoch;

  final int interval;
  final String secret;

  late final _Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  TotpCubit(this.secret, [this.interval = kInerval])
      : super(
          TotpState(
            interval: interval,
            expiresIn: _remainingTime(interval),
            totp: _generateTotp(secret, interval),
          ),
        ) {
    _ticker = _Ticker();
  }

  static int _remainingTime(int interval) {
    return interval - (_now ~/ 1000) % interval;
  }

  static String _generateTotp(String secret, int interval) {
    return OTP.generateTOTPCodeString(
      secret,
      _now,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
      interval: interval,
    );
  }

  void start() {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(state.expiresIn).listen(
      (duration) {
        emit(state.copyWith(expiresIn: duration));
      },
      onDone: () => startNewInterval(),
    );
  }

  void startNewInterval() {
    emit(
      state.copyWith(
        expiresIn: interval,
        totp: _generateTotp(secret, interval),
      ),
    );

    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(interval).listen(
      (duration) {
        emit(state.copyWith(expiresIn: duration));
      },
      onDone: () => startNewInterval(),
    );
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}

class _Ticker {
  Stream<int> tick(int ticks) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}
