import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) => throw UnimplementedError();

  @override
  String toJson(DateTime dateTime) => dateTime.toUtc().toIso8601String();
}
