import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../l10n/tr.dart';
import '../register/register_page.dart';
import '../session/cubits/session_cubit.dart';
import 'home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionCubit>(
      create: (_) => SessionCubit(),
      child: AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tazkrtak',
      navigatorKey: _navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocListener<SessionCubit, SessionState>(
        listener: (context, state) {
          if (state is SessionLoading) {
            print("here");
            Text(tr(context).common_loading);
          } else if (state is SessionSuccess) {
            print("here2");
            _navigator.pushAndRemoveUntil<void>(
              HomePage.route(),
              (route) => false,
            );
          } else if (state is SessionUnknown) {
            _navigator.pushAndRemoveUntil<void>(
              RegisterPage.route(),
              (route) => false,
            );
          } else {
            Text(tr(context).error_generic);
          }
        },
      ),
    );
  }
}
