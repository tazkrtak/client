import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
          horizontal: 16,
          vertical: 8,
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
                      fontWeight: FontWeight.w300, fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  trDateTime(context, date),
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.black54),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              amount.isNegative
                  ? LineAwesomeIcons.minus
                  : LineAwesomeIcons.plus,
              color: amount.isNegative
                  ? Theme.of(context).errorColor
                  : Theme.of(context).primaryColor,
              size: 16,
            ),
            Text(
              '${trNumber(context, amount.abs())} ${tr(context).app_currency}',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24,
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
