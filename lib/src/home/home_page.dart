import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../account/account_page.dart';
import '../register/cubits/register_cubit.dart';
import '../register/register_page.dart';
import '../wallet/wallet_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomSelectedIndex = 0;

  PageController pageController = PageController();

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        WalletPage(),
        AccountPage(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void onBottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => {
                    BlocProvider.of<RegisterCubit>(context)
                        .signOut()
                        .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            ))
                  })
        ],
      ),
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: bottomSelectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onBottomTapped,
      ),
    );
  }
}
