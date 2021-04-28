import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../account/account_page.dart';
import '../ticket/ticket_page.dart';
import '../wallet/wallet_page.dart';

class HomePage extends HookWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex.value,
          children: [
            TicketPage(),
            WalletPage(),
            AccountPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (index) => currentIndex.value = index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
