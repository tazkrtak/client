import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/tr.dart';
import '../account/account_page.dart';
import '../ticket/ticket.dart';
import '../wallet/wallet_page.dart';
import 'cubits/session_cubit.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context).appTitle),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<SessionCubit>().clearSession(),
          )
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          TicketPage(),
          WalletPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
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
