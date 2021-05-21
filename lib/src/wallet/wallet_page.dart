import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../l10n/tr.dart';
import 'cubits/credit_cubit.dart';
import 'cubits/date_range_cubit.dart';
import 'cubits/transactions_cubit.dart';
import 'cubits/transactions_summary_cubit.dart';
import 'widgets/date_range_picker.dart';
import 'widgets/overview_cards.dart';
import 'widgets/transactions_list.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DateRangeCubit()),
        // TODO: Get summary on creating the cubit
        BlocProvider(create: (_) => TransactionsSummaryCubit()),
        BlocProvider(create: (_) => CreditCubit()..getBalance()),
        BlocProvider(create: (_) => TransactionsCubit()),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<DateRangeCubit, DateRangeState>(
                  listener: (context, state) => _reload(context)),
              BlocListener<TransactionsSummaryCubit, TransactionsSummaryState>(
                listener: (context, state) {
                  if (state is TransactionsSummaryError) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          backgroundColor: Theme.of(context).errorColor,
                          content:
                              Text(state.message ?? tr(context).error_generic),
                        ),
                      );
                  }
                },
              ),
              BlocListener<CreditCubit, CreditState>(
                listener: (context, state) {
                  if (state is CreditError) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          backgroundColor: Theme.of(context).errorColor,
                          content:
                              Text(state.message ?? tr(context).error_generic),
                        ),
                      );
                  }
                },
              ),
            ],
            child: Scaffold(
              body: SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async => _reload(context),
                  child: CustomScrollView(
                    slivers: [
                      SliverPinnedHeader(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          color: Theme.of(context).canvasColor,
                          child: const DateRangePicker(),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          bottom: 24,
                          left: 24,
                          right: 24,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: OverviewCards(),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          bottom: 24,
                          left: 24,
                          right: 24,
                        ),
                        sliver: TransactionsList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _reload(BuildContext context) {
    context.read<TransactionsCubit>().refresh();
    final dateRangeState = context.read<DateRangeCubit>().state;
    context
        .read<TransactionsSummaryCubit>()
        .getSummary(dateRangeState.toDateFilter());
  }
}
