import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/tr.dart';
import '../app/cubits/session_cubit.dart';
import '../register/cubits/register_cubit.dart';
import 'widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<RegisterCubit>(
          create: (_) => RegisterCubit(),
          child: RegisterForm(
            onFormSuccess: (user) {
              context.read<SessionCubit>().startSession(user);
            },
            onFormFailure: (error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(error ?? tr(context).error_generic),
                  ),
                );
            },
          ),
        ),
      ),
    );
  }
}
