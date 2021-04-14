part of 'totp_cubit.dart';

class TotpState extends Equatable {
  final int expiresIn;
  final int interval;
  final String totp;

  double get progress => expiresIn / interval;
  bool get isNewInterval => expiresIn == interval;

  const TotpState({
    required this.expiresIn,
    required this.interval,
    required this.totp,
  });

  TotpState copyWith({
    int? expiresIn,
    int? interval,
    String? totp,
  }) {
    return TotpState(
      expiresIn: expiresIn ?? this.expiresIn,
      interval: interval ?? this.interval,
      totp: totp ?? this.totp,
    );
  }

  @override
  List<Object> get props => [
        expiresIn,
        interval,
        totp,
      ];
}
