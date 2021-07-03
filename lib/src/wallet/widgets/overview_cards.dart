import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../l10n/tr.dart';
import '../../../widgets/widgets.dart';
import '../cubits/credit_cubit.dart';
import '../cubits/transactions_summary_cubit.dart';

class OverviewCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 256,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: _BalanceCard(),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _RechargeActionCard(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _SummaryCard(
                    color: Theme.of(context).primaryColor,
                    icon: LineAwesomeIcons.arrow_down,
                    title: tr(context).wallet_recharged,
                    amountResolver: (state) => state.recharged,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _SummaryCard(
                    color: Theme.of(context).errorColor,
                    icon: LineAwesomeIcons.arrow_up,
                    title: tr(context).wallet_spent,
                    amountResolver: (state) => state.spent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).highlightColor,
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(context).wallet_currentBalance,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<CreditCubit, CreditState>(
              builder: (context, state) {
                return Text(
                  state is CreditSuccess
                      ? trNumber(context, state.balance)
                      : '—',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                );
              },
            ),
            Text(
              tr(context).app_currency,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            const Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Icon(
                LineAwesomeIcons.coins,
                color: Colors.black87,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RechargeActionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
              ),
            ),
        onPressed: () {
          // TODO: Move recharge logic to Cubit after adding recharge screen
          context.read<CreditCubit>().recharge(50);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr(context).wallet_recharge,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const Icon(
              LineAwesomeIcons.chevron_circle_right,
              color: Colors.white,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final double Function(TransactionsSummarySuccess) amountResolver;

  const _SummaryCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.amountResolver,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.cardPadding),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                BlocBuilder<TransactionsSummaryCubit, TransactionsSummaryState>(
                  builder: (context, state) {
                    return Text(
                      state is TransactionsSummarySuccess
                          ? trNumber(context, amountResolver(state).round())
                          : '—',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 24,
                      ),
                    );
                  },
                ),
                Text(
                  tr(context).app_currency,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
