import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/tr.dart';
import '../app/cubits/session_cubit.dart';
import '../login/cubits/login_cubit.dart';
import 'widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginCubit>(
        create: (_) => LoginCubit(),
        child: LoginForm(
          onFormFailure: (error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(error ?? tr(context).error_generic),
                ),
              );
          },
          onFormSucces: (user) {
            context.read<SessionCubit>().startSession(user);
          },
        ),
      ),
    );
  }
}
