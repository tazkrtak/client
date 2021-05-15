import 'package:flutter/material.dart';

import 'overview_cards.dart';

class WalletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OverViewCards(),
      ],
    );
  }
}
