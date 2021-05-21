import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../api.dart';
import '../common/models/base_paginated_query.dart';
import '../common/models/date_filter.dart';

part 'transactions_service.g.dart';

@RestApi()
abstract class TransactionsService {
  factory TransactionsService(Dio dio) = _TransactionsService;

  @POST('/transactions')
  Future<PaginatedModel<Transaction>> get(
      @Body() BasePaginatedQuery<DateFilter> registerBody);

  @POST('/transactions/summary')
  Future<TransactionsSummary> getSummary(@Body() DateFilter filter);
}
