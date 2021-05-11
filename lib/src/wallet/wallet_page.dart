import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/overview_cards.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OverViewCards(),
      ],
    ));
  }
}