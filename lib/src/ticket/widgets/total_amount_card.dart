import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/tr.dart';

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
        vertical: 16,
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
            '${trNumber(value)} ${tr(context).ticket_priceTitle}',
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
