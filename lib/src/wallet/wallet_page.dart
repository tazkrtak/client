import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/wallet_view.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: WalletView(),
        ),
      ),
    );
  }
}
