import 'package:otp/otp.dart';

extension Totp on OTP {
  static const interval = 30;

  static int get _now => DateTime.now().millisecondsSinceEpoch;

  static int get expiresIn => interval - (_now ~/ 1000) % interval - 1;

  static String generateCode(String secret) {
    return OTP
        .generateTOTPCodeString(
          secret,
          _now,
          // ignore: avoid_redundant_argument_values
          interval: interval,
        );
  }
}
