import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/widgets.dart';
import '../app/cubits/session_cubit.dart';
import 'cubits/ticket_cubit.dart';
import 'cubits/totp_cubit.dart';
import 'widgets/ticket_form.dart';

class TicketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    final user = (sessionCubit.state as SessionSuccess).user;

    return Scaffold(
      body: BlocProvider(
        create: (_) => TotpCubit(user.secret)..start(),
        child: Builder(
          builder: (context) => BlocProvider(
            create: (_) => TicketCubit(
              user.id,
              user.key,
              context.read<TotpCubit>().state.totp,
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.pagePadding),
                  child: TicketForm(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
