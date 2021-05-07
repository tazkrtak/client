import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../l10n/tr.dart';

class TotalAmount extends StatelessWidget {
  final double totalAmount;
  const TotalAmount({required this.totalAmount});

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
            '${_format(totalAmount)}\t${tr(context).ticket_priceTitle}',
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

  String _format(double n) =>
      n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
}
