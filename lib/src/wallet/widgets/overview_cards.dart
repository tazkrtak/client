import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../l10n/tr.dart';
import '../transactions/cubits/transactions_summary_cubit.dart';

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
                  child: _RechargedCard(),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _SpentCard(),
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
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(context).wallet_currentBalance,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<TransactionsSummaryCubit, TransactionsSummaryState>(
              builder: (context, state) {
                return state is TransactionsSummarySuccess
                    ? RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: trNumber(context, state.balance.round()),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 48,
                              ),
                            ),
                            const TextSpan(text: '\n'),
                            TextSpan(
                              text: tr(context).app_currency,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const Icon(
                        LineAwesomeIcons.minus,
                        color: Colors.black87,
                      );
              },
            ),
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
    return InkWell(
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
      ),
    );
  }
}

class _RechargedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              LineAwesomeIcons.arrow_up,
              color: Theme.of(context).primaryColor,
              size: 32,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr(context).wallet_recharged,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<TransactionsSummaryCubit, TransactionsSummaryState>(
                  builder: (context, state) {
                    return state is TransactionsSummarySuccess
                        ? RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: trNumber(
                                      context, state.recharged.round()),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    fontSize: 24,
                                  ),
                                ),
                                const TextSpan(text: ' '),
                                TextSpan(
                                  text: tr(context).app_currency,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Icon(
                            LineAwesomeIcons.minus,
                            color: Colors.black87,
                          );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SpentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).errorColor.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              LineAwesomeIcons.arrow_down,
              color: Theme.of(context).errorColor,
              size: 32,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr(context).wallet_spent,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<TransactionsSummaryCubit, TransactionsSummaryState>(
                  builder: (context, state) {
                    return state is TransactionsSummarySuccess
                        ? RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: trNumber(context, state.spent.round()),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      fontSize: 24),
                                ),
                                const TextSpan(text: ' '),
                                TextSpan(
                                  text: tr(context).app_currency,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Icon(
                            LineAwesomeIcons.minus,
                            color: Colors.black87,
                          );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
