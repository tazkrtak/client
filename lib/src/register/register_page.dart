import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/tr.dart';
import '../register/cubits/register_cubit.dart';
import '../session/cubits/session_cubit.dart';

class RegisterPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider<RegisterCubit>(
          create: (_) => RegisterCubit(),
          child: RegisterView(),
        ),
      ),
    );
  }
}

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSucess) {
          context.read<SessionCubit>().emit(
                SessionSuccess(state.user),
              );
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(tr(context).error_generic),
              ),
            );
        } else {
          return;
        }
      },
      child: Center(
        child: Column(
          children: [
            _RegisterButton(),
          ],
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => current is SessionUnknown,
      builder: (context, state) {
        return Center(
          child: ElevatedButton(
            onPressed: state is RegisterLoading
                ? null
                : () => {
                      context.read<RegisterCubit>().register(),
                    },
            child: state is RegisterLoading
                ? const CircularProgressIndicator()
                : Text(tr(context).register_title),
          ),
        );
      },
    );
  }
}
