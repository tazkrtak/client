import 'package:flutter/material.dart';

import '../../../l10n/tr.dart';

class TransactionCard extends StatelessWidget {
  final String reason;
  final DateTime date;
  final double amount;

  const TransactionCard({
    required this.reason,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).highlightColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reason,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  trDateTime(context, date),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Text(
              "${amount.isNegative ? '-' : '+'}"
              '${trNumber(context, amount.abs())} ${tr(context).app_currency}',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: amount.isNegative
                    ? Theme.of(context).errorColor
                    : Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
