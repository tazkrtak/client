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
    final sessionCubit = context.read<SessionCubit>();
    final user = (sessionCubit.state as SessionSuccess).user;
    final phoneMaskFormatter =
        MaskTextInputFormatter(mask: PhoneNumber.kMaskFormat);
    final nationalIdMaskFormatter =
        MaskTextInputFormatter(mask: NationalId.kMaskFormat);
    return Scaffold(
      body: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 40, right: 16),
            child: Column(
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
                  title: Text(
                    tr(context).register_phoneNumberHint,
                  ),
                  subtitle: Text(phoneMaskFormatter.maskText(user.phoneNumber)),
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
                      Text(nationalIdMaskFormatter.maskText(user.nationalId)),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () => context.read<SessionCubit>().clearSession(),
                  child: Text(
                    tr(context).account_sign_out,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
