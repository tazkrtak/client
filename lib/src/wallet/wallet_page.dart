import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const DateRangePicker(),
                          const SizedBox(height: 16),
                          OverviewCards(),
                          const SizedBox(height: 24),
                          TransactionsList(),
                        ],
                      ),
                    ),
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
