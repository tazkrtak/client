import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../l10n/tr.dart';
import '../app/cubits/session_cubit.dart';
import '../register/models/models.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phoneFormatter = MaskTextInputFormatter(
      mask: PhoneNumber.kMaskFormat,
    );
    final nationalIdFormatter = MaskTextInputFormatter(
      mask: NationalId.kMaskFormat,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<SessionCubit, SessionState>(
            // Prevents rebuilding the page when the user
            // signs out (i.e. state changes to SessionUnknown)
            buildWhen: (_, current) => current is SessionSuccess,
            builder: (context, state) {
              final user = (state as SessionSuccess).user;
              return Column(
                children: [
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
                    subtitle: Text(phoneFormatter.maskText(user.phoneNumber)),
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
                    subtitle:
                        Text(nationalIdFormatter.maskText(user.nationalId)),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<SessionCubit>().clearSession(),
                    child: Text(tr(context).account_sign_out),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
