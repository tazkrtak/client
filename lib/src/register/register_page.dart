import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../api/user/models/user.dart';
import '../../common/cubits/form_cubit/form_cubit.dart' as cubit;
import '../../l10n/tr.dart';
import '../app/cubits/session_cubit.dart';
import '../register/cubits/register_cubit.dart';
import 'cubits/register_inputs.dart';
import 'models/models.dart';

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
    return BlocListener<RegisterCubit, cubit.FormState<RegisterInputs, User>>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          context.read<SessionCubit>().startSession(state.result!.value!);
        } else if (state.status == FormzStatus.submissionFailure) {
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
      child: Column(
        children: [
          _EmailField(),
          _NationalIdField(),
          _FullNameField(),
          _PhoneNumberField(),
          _PasswordField(),
          _RegisterButton(),
        ],
      ),
    );
  }
}

class _EmailField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, cubit.FormState<RegisterInputs, User>>(
      // buildWhen: (previous, current) {
      //   return previous.inputs!.email != current.inputs!.email;
      // },
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            print(email);
            context.read<RegisterCubit>().updateEmail(Email.dirty(email));
          },
          // context.read<RegisterCubit>().updateEmail(Email.dirty(email)),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.at),
            // hintText: tr(context).login_emailHint,
            errorText: state.inputs.email.getErrorText(context),
          ),
        );
      },
    );
  }
}

class _FullNameField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, cubit.FormState<RegisterInputs, User>>(
      buildWhen: (previous, current) {
        return previous.inputs.fullName != current.inputs.fullName;
      },
      builder: (context, state) {
        return TextField(
          onChanged: (fullName) => context
              .read<RegisterCubit>()
              .updateFullName(FullName.dirty(fullName)),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.user_circle_1),
            // hintText: tr(context).login_emailHint,
            errorText: state.inputs.email.getErrorText(context),
          ),
        );
      },
    );
  }
}

class _PhoneNumberField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, cubit.FormState<RegisterInputs, User>>(
      buildWhen: (previous, current) {
        return previous.inputs.phoneNumber != current.inputs.phoneNumber;
      },
      builder: (context, state) {
        return TextField(
          onChanged: (phoneNumber) => context
              .read<RegisterCubit>()
              .updatePhoneNumber(PhoneNumber.dirty(phoneNumber)),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.phone),
            // hintText: tr(context).login_emailHint,
            errorText: state.inputs.email.getErrorText(context),
          ),
        );
      },
    );
  }
}

class _NationalIdField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, cubit.FormState<RegisterInputs, User>>(
      buildWhen: (previous, current) {
        return previous.inputs.nationalId != current.inputs.nationalId;
      },
      builder: (context, state) {
        return TextField(
          onChanged: (nationalId) => context
              .read<RegisterCubit>()
              .updateNationalId(NationalId.dirty(nationalId)),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.envelope),
            // hintText: tr(context).login_emailHint,
            errorText: state.inputs.email.getErrorText(context),
          ),
        );
      },
    );
  }
}

class _PasswordField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, cubit.FormState<RegisterInputs, User>>(
      buildWhen: (previous, current) {
        return previous.inputs.password != current.inputs.password;
      },
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (password) => context
              .read<RegisterCubit>()
              .updatePassword(Password.dirty(password)),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.eye),
            // hintText: tr(context).login_emailHint,
            errorText: state.inputs.email.getErrorText(context),
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, cubit.FormState<RegisterInputs, User>>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: !state.status.isValidated
              ? null
              : () => context.read<RegisterCubit>().submitForm(),
          child: state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : Text(tr(context).register_title),
        );
      },
    );
  }
}
