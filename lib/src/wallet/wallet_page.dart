import 'package:flutter/material.dart';
import '../../models/user.dart';

class WalletPage extends StatelessWidget {
  final User user;

  const WalletPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is ${user.name} Wallet!'),
      ),
    );
  }
}
