import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import 'transactions/cubits/transactions_cubit.dart';
import 'transactions/cubits/transactions_summary_cubit.dart';
import 'transactions/widgets/transactions_list.dart';
import 'widgets/date_range_picker.dart';
import 'widgets/overview_cards.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final initialDateRange = DateRangePicker.ranges['${RangeType.oneWeek}']!;
    return MultiBlocProvider(
      providers: [
        BlocProvider<TransactionsCubit>(
          create: (_) =>
              TransactionsCubit(initialFilter: DateFilter(initialDateRange)),
        ),
        BlocProvider<TransactionsSummaryCubit>(
          create: (_) => TransactionsSummaryCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                  () {
                    _onRefresh(context);
                  },
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DateRangePicker(
                          onChange: (from) {
                            _onUpdateFilter(context, from);
                          },
                        ),
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
          );
        },
      ),
    );
  }

  void _onUpdateFilter(BuildContext context, DateTime from) {
    context.read<TransactionsCubit>().updateFilter(DateFilter(from));
  }

  void _onRefresh(BuildContext context) {
    context.read<TransactionsCubit>().refresh();
    context.read<TransactionsSummaryCubit>().getSummary();
  }
}
