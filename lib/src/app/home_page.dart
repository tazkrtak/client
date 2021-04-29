import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          hoverColor: Theme.of(context).primaryColor,
          onTabChange: (index) => currentIndex.value = index,
          tabBorderRadius: 16,
          tabMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          gap: 8,
          activeColor: Theme.of(context).highlightColor,
          iconSize: 30,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: Theme.of(context).primaryColor,
          tabBorder: Border.all(color: Colors.transparent, width: 3),
          color: Colors.black,
          tabs: const [
            GButton(
              icon: LineAwesomeIcons.alternate_ticket,
              text: 'Ticket',
            ),
            GButton(
              icon: LineAwesomeIcons.wallet,
              text: 'Wallet',
            ),
            GButton(
              icon: LineAwesomeIcons.user_circle,
              text: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
