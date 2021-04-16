import 'dart:convert';

String prettyJson(dynamic source, {int indent = 2}) {
  final spaces = ' ' * indent;
  final encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(source);
}
