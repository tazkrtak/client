import 'base_filter.dart';

class BasePaginatedQuery<T extends BaseFilter> {
  final int page;
  final int pageSize;
  final T filter;

  const BasePaginatedQuery({
    required this.page,
    required this.pageSize,
    required this.filter,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'page_size': pageSize,
        'filter': filter.toJson(),
      };
}
