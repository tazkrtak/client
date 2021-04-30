import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../l10n/tr.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: IndexedStack(
            index: currentIndex.value,
            children: [
              TicketPage(),
              WalletPage(),
              AccountPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: GNav(
          gap: 12,
          iconSize: 32,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          tabBorderRadius: 16,
          tabBackgroundColor: Theme.of(context).primaryColor,
          color: Colors.black,
          activeColor: Theme.of(context).backgroundColor,
          duration: const Duration(milliseconds: 400),
          onTabChange: (index) => currentIndex.value = index,
          tabs: [
            GButton(
              icon: LineAwesomeIcons.alternate_ticket,
              text: tr(context).bottomNav_ticket,
            ),
            GButton(
              icon: LineAwesomeIcons.wallet,
              text: tr(context).bottomNav_wallet,
            ),
            GButton(
              icon: LineAwesomeIcons.user_circle,
              text: tr(context).bottomNav_account,
            ),
          ],
        ),
      ),
    );
  }
}
