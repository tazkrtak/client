import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../l10n/tr.dart';
import '../app/cubits/session_cubit.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    final user = (sessionCubit.state as SessionSuccess).user;
    return Scaffold(
      body: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 40, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => context.read<SessionCubit>().clearSession(),
                  child: Text(
                    tr(context).account_sign_out,
                  ),
                ),
                const Center(
                  child: Icon(
                    LineAwesomeIcons.user,
                    size: 180,
                  ),
                ),
                // const SizedBox(height: 32),
                ListTile(
                  leading: Icon(
                    LineAwesomeIcons.user,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(tr(context).register_fullNameHint),
                  subtitle: Text(user.fullName),
                ),
                ListTile(
                  leading: Icon(
                    LineAwesomeIcons.phone,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(tr(context).register_phoneNumberHint),
                  subtitle: Text(user.phoneNumber),
                ),
                ListTile(
                  leading: Icon(
                    LineAwesomeIcons.at,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(tr(context).register_emailHint),
                  subtitle: Text(user.email),
                ),
                ListTile(
                  leading: Icon(
                    LineAwesomeIcons.identification_card_1,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(tr(context).register_nationalIdHint),
                  subtitle: Text(user.nationalId),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
