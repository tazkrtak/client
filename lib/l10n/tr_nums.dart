import 'dart:io';
import 'package:intl/intl.dart';

String trNums(num number) {
  final formatter = NumberFormat('###.#', Platform.localeName);
  return formatter.format(num.parse(format(number)));
}

String format(num n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}
