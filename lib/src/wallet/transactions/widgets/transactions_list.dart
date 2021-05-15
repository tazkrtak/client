import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../l10n/tr.dart';
import '../cubits/transactions_cubit.dart';
import '../cubits/transactions_state.dart';
import '../../../../common/hooks/paging_hook.dart';
import '../models/transaction.dart';
import 'transaction_card.dart';

class TransactionsList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionsCubit>();
    final _pagingController = usePagingController<Transaction>(
      1,
      (pageIndex) => cubit.fetch(pageIndex),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transactions',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        BlocListener<TransactionsCubit, TransactionsState>(
          listener: (context, state) {
            if (state is TransactionSuccess) {
              if (state.isLastPage) {
                _pagingController.appendLastPage(state.transactions);
              } else {
                _pagingController.appendPage(state.transactions,
                    state.isLastPage ? null : state.nextPageKey);
              }
            } else if (state is TransactionsError) {
              _pagingController.error =
                  state.message ?? tr(context).error_generic;
            } else if (state is TransactionsRefresh) {
              _pagingController.refresh();
            }
          },
          child: PagedListView.separated(
            primary: false,
            shrinkWrap: true,
            pagingController: _pagingController,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            builderDelegate: PagedChildBuilderDelegate<Transaction>(
              itemBuilder: (context, transaction, index) => TransactionCard(
                reason: transaction.reason,
                date: transaction.date,
                amount: transaction.amount,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
