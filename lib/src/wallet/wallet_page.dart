import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'transactions/cubits/date_range_cubit.dart';
import 'transactions/cubits/transactions_cubit.dart';
import 'transactions/cubits/transactions_summary_cubit.dart';
import 'transactions/widgets/transactions_list.dart';
import 'widgets/date_range_picker.dart';
import 'widgets/overview_cards.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DateRangeCubit()),
        BlocProvider(create: (_) => TransactionsSummaryCubit()),
        BlocProvider(create: (_) => TransactionsCubit()),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<DateRangeCubit, DateRangeState>(
            listener: (context, state) => _reload(context),
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
    context.read<TransactionsSummaryCubit>().getSummary();
  }
}
