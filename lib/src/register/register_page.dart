import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/tr.dart';
import '../app/home_page.dart';
import '../register/cubits/register_cubit.dart';

class RegisterPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              Text(tr(context).common_loading);
            } else if (state is RegisterSucess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              Text(tr(context).error_generic);
            }
          },
          child: ElevatedButton(
            onPressed: () {
              context.read<RegisterCubit>().register();
            },
            child: Text(tr(context).register_title),
          ),
        ),
      ),
    );
  }
}
