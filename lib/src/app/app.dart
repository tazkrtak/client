import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../widgets/widgets.dart';
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

class AppView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final navigatorKey = useState(GlobalKey<NavigatorState>());

    return MaterialApp(
      title: 'Tazkrtak',
      navigatorKey: navigatorKey.value,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().data,
      onGenerateRoute: (_) => SplashPage.route(),
      builder: (context, child) {
        return BlocListener<SessionCubit, SessionState>(
          listener: (context, state) {
            final navigator = navigatorKey.value.currentState!;
            final route = state is SessionSuccess
                ? HomePage.route()
                : RegisterPage.route();

            navigator.pushAndRemoveUntil<void>(
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
