import 'package:flutter/material.dart';

import '../../../api/api.dart';
import '../../../l10n/tr.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard(this.transaction);

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
                  transaction.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  trDateTime(context, transaction.createdAt),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Text(
              "${transaction.amount.isNegative ? '-' : '+'}"
              '${trNumber(context, transaction.amount.abs())} '
              '${tr(context).app_currency}',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: transaction.amount.isNegative
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
