import 'package:json_annotation/json_annotation.dart';

part 'paginated_model.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
  genericArgumentFactories: true,
)
class PaginatedModel<T> {
  final int page;
  final int pageSize;
  final bool isLast;
  final int total;
  final List<T> items;

  const PaginatedModel({
    required this.page,
    required this.pageSize,
    required this.isLast,
    required this.total,
    required this.items,
  });

  factory PaginatedModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedModelFromJson(json, fromJsonT);
}
