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
      child: MaterialApp(
        title: 'Tazkrtak',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocListener<SessionCubit, SessionState>(
          listener: (context, state) {
            if (state is SessionLoading) {
              Text(tr(context).common_loading);
            } else if (state is SessionSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            } else if (state is SessionUnknown) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              );
            } else {
              Text(tr(context).error_generic);
            }
          },
        ),
      ),
    );
  }
}
