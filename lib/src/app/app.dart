import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../l10n/tr.dart';
import '../home/home_page.dart';
import '../register/cubits/register_cubit.dart';
import '../register/register_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (_) => RegisterCubit(),
      child: MaterialApp(
          title: 'Tazkrtak',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
            if (state is RegisterLoading) {
              return RegisterPage();
            } else if (state is RegisterSucess) {
              return HomePage();
            } else {
              return Text(tr(context).error_generic);
            }
          })),
    );
  }
}
