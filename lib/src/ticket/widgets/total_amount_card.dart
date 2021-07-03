import 'package:flutter/material.dart';

import '../../../l10n/tr.dart';
import '../../../widgets/theme.dart';

class TotalAmountCard extends StatelessWidget {
  final double value;

  const TotalAmountCard({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 64,
        vertical: AppDimens.cardPadding,
      ),
      child: Column(
        children: [
          Text(
            tr(context).ticket_totalAmount,
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '${trNumber(context, value)} ${tr(context).app_currency}',
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
