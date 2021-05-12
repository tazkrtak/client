import 'dart:io';
import 'package:intl/intl.dart';

String trNums(dynamic num) {
  final formatter = NumberFormat('###.0#', Platform.localeName);
  return formatter.format(num);
}
