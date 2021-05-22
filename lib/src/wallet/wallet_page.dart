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
        BlocProvider(create: (_) => CreditCubit()..getBalance()),
        BlocProvider(create: (_) => TransactionsCubit()),
        BlocProvider(
          create: (_) => TransactionsSummaryCubit()
            ..getSummary(DateRangeCubit.initialState.dateFilter),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<DateRangeCubit, DateRange>(
                listener: (context, state) => _onRangeUpdated(context),
              ),
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
              appBar: AppBar(
                toolbarHeight: 80,
                title: const DateRangePicker(),
                backgroundColor: Theme.of(context).canvasColor,
                elevation: 0,
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  context.read<CreditCubit>().getBalance();
                  _onRangeUpdated(context);
                },
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        right: 16,
                        left: 16,
                      ),
                      sliver: MultiSliver(
                        children: [
                          OverviewCards(),
                          SliverPinnedHeader(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              color: Theme.of(context).canvasColor,
                              child: Text(
                                tr(context).wallet_transactions,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TransactionsList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onRangeUpdated(BuildContext context) {
    final range = context.read<DateRangeCubit>().state;
    context.read<TransactionsSummaryCubit>().getSummary(range.dateFilter);
    context.read<TransactionsCubit>().refresh();
  }
}
