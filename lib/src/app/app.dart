import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../register/register_page.dart';
import 'cubits/session_cubit.dart';
import 'home_page.dart';
import 'splash_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionCubit>(
      create: (_) {
        final cubit = SessionCubit();

        // Delay to force showing SplashPage, (works in release only).
        const delay = kReleaseMode ? Duration(seconds: 3) : Duration();
        Future.delayed(
          delay,
          () => cubit.loadSession(),
        );

        return cubit;
      },
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
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (_) => SplashPage.route(),
      builder: (context, child) {
        return BlocListener<SessionCubit, SessionState>(
          listener: (context, state) {
            final route = state is SessionSuccess
                ? HomePage.route()
                : RegisterPage.route();

            _navigator.pushAndRemoveUntil<void>(
              route,
              (route) => false,
            );
          },
          child: child,
        );
      },
    );
  }
}
