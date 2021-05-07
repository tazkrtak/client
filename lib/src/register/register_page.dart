import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../api/user/models/user.dart';
import '../../common/cubits/form_cubit/form_cubit.dart' as cubit;
import '../../l10n/tr.dart';
import '../../widgets/widgets.dart' as widgets;
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
          _FullNameField(),
          const SizedBox(height: 10),
          _PhoneNumberField(),
          const SizedBox(height: 10),
          _EmailField(),
          const SizedBox(height: 10),
          _NationalIdField(),
          const SizedBox(height: 10),
          _PasswordField(),
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(value: false, onChanged: (val) {}),
              RichText(
                text: TextSpan(
                  text: tr(context).register_agree,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: tr(context).register_terms,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                    TextSpan(text: tr(context).register_and),
                    TextSpan(
                        text: tr(context).register_privacyPolicy,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                  ],
                ),
              )
            ],
          ),
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
      builder: (context, state) {
        return widgets.FilledTextField(
          prefixIcon: const Icon(LineAwesomeIcons.at),
          onChanged: (email) =>
              context.read<RegisterCubit>().updateEmail(Email.dirty(email)),
          errorText: state.inputs.email.getErrorText(context),
          hintText: tr(context).register_emailHint,
        );
      },
    );
  }
}

class _FullNameField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, cubit.FormState<RegisterInputs, User>>(
      builder: (context, state) {
        return widgets.FilledTextField(
          prefixIcon: const Icon(LineAwesomeIcons.user_circle_1),
          onChanged: (fullName) => context
              .read<RegisterCubit>()
              .updateFullName(FullName.dirty(fullName)),
          errorText: state.inputs.fullName.getErrorText(context),
          hintText: tr(context).register_fullNameHint,
        );
      },
    );
  }
}

class _PhoneNumberField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, cubit.FormState<RegisterInputs, User>>(
      builder: (context, state) {
        return widgets.FilledTextField(
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(LineAwesomeIcons.phone),
          onChanged: (phoneNumber) => context
              .read<RegisterCubit>()
              .updatePhoneNumber(PhoneNumber.dirty(phoneNumber)),
          errorText: state.inputs.phoneNumber.getErrorText(context),
          hintText: tr(context).register_phoneNumberHint,
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
        return widgets.FilledTextField(
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(LineAwesomeIcons.identification_card_1),
          onChanged: (nationalId) => context
              .read<RegisterCubit>()
              .updateNationalId(NationalId.dirty(nationalId)),
          errorText: state.inputs.nationalId.getErrorText(context),
          hintText: tr(context).register_nationalIdHint,
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
        return widgets.PasswordTextField(
          onChanged: (password) => context
              .read<RegisterCubit>()
              .updatePassword(Password.dirty(password)),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.unlock),
            hintText: tr(context).register_passwordHint,
            errorText: state.inputs.password.getErrorText(context),
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
