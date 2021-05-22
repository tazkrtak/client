import 'package:json_annotation/json_annotation.dart';

import '../date_time_converter.dart';
import 'base_filter.dart';

part 'date_filter.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
@DateTimeConverter()
class DateFilter extends BaseFilter {
  final DateTime from;

  const DateFilter(this.from);

  @override
  Map<String, dynamic> toJson() => _$DateFilterToJson(this);
}
