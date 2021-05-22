import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../api/api.dart';
import '../../../common/hooks/paging_hook.dart';
import '../../../l10n/tr.dart';
import '../cubits/date_range_cubit.dart';
import '../cubits/transactions_cubit.dart';
import 'transaction_card.dart';

class TransactionsList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionsCubit>();
    final _pagingController = usePagingController<Transaction>(
      (pageIndex) {
        final rangeState = context.read<DateRangeCubit>().state;
        return cubit.fetch(pageIndex, rangeState.dateFilter);
      },
    );

    return MultiSliver(
      children: [
        SliverPinnedHeader(
          child: Container(
            padding: const EdgeInsets.only(bottom: 16),
            color: Theme.of(context).canvasColor,
            child: Text(
              tr(context).wallet_transactions,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        BlocListener<TransactionsCubit, TransactionsState>(
          listener: (context, state) {
            if (state is TransactionSuccess) {
              if (state.isLast) {
                _pagingController.appendLastPage(state.transactions);
              } else {
                _pagingController.appendPage(
                  state.transactions,
                  state.nextPageKey,
                );
              }
            } else if (state is TransactionsError) {
              final message = state.message ?? tr(context).error_generic;
              _pagingController.error = message;
            } else if (state is TransactionsRefresh) {
              _pagingController.refresh();
            }
          },
          child: PagedSliverList.separated(
            pagingController: _pagingController,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            builderDelegate: PagedChildBuilderDelegate<Transaction>(
              itemBuilder: (context, transaction, index) => TransactionCard(
                reason: transaction.title,
                date: transaction.createdAt,
                amount: transaction.amount,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
