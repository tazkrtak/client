import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../api/user/models/models.dart';
import '../../../common/cubits/form_cubit/form_cubit.dart';
import '../../../common/hooks/debounce.dart';
import '../../../l10n/tr.dart';
import '../../../widgets/widgets.dart';
import '../cubits/register_cubit.dart';
import '../cubits/register_inputs.dart';
import '../models/models.dart';

class RegisterForm extends StatelessWidget {
  final ValueChanged<User> onFormSucces;
  final ValueChanged<String?> onFormFailure;

  const RegisterForm({
    required this.onFormSucces,
    required this.onFormFailure,
  });

  @override
  Widget build(BuildContext context) {
    return FieldBlocListener<RegisterCubit, RegisterInputs, User>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          onFormSucces(state.result!.value!);
        } else if (state.status.isSubmissionFailure) {
          onFormFailure(state.result?.error);
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 65,
              child: Image.asset('assets/logo.png'),
            ),
            const SizedBox(height: 32),
            _FullNameField(),
            const SizedBox(height: 8),
            _PhoneNumberField(),
            const SizedBox(height: 8),
            _EmailField(),
            const SizedBox(height: 8),
            _NationalIdField(),
            const SizedBox(height: 8),
            _PasswordField(),
            const SizedBox(height: 16),
            _AgreeOnTermsCheckBox(),
            const SizedBox(height: 32),
            _RegisterButton(),
          ],
        ),
      ),
    );
  }
}

class _FullNameField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final debounce = useDebounce();

    return FieldBlocBuilder<RegisterCubit, RegisterInputs>(
      buildWhen: (previous, current) =>
          previous.inputs.fullName != current.inputs.fullName,
      builder: (context, state) {
        return TextField(
          onChanged: (fullName) => debounce(
            () => context.read<RegisterCubit>().updateFullName(
                  FullName.dirty(fullName),
                ),
          ),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.user_circle_1),
            errorText: state.inputs.fullName.getErrorText(context),
            hintText: tr(context).register_fullNameHint,
          ),
        );
      },
    );
  }
}

class _PhoneNumberField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final debounce = useDebounce();

    return FieldBlocBuilder<RegisterCubit, RegisterInputs>(
      buildWhen: (previous, current) =>
          previous.inputs.phoneNumber != current.inputs.phoneNumber,
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.phone,
          onChanged: (phoneNumber) => debounce(
            () => context.read<RegisterCubit>().updatePhoneNumber(
                  PhoneNumber.dirty(phoneNumber),
                ),
          ),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.phone),
            errorText: state.inputs.phoneNumber.getErrorText(context),
            hintText: tr(context).register_phoneNumberHint,
          ),
        );
      },
    );
  }
}

class _EmailField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final debounce = useDebounce();

    return FieldBlocBuilder<RegisterCubit, RegisterInputs>(
      buildWhen: (previous, current) =>
          previous.inputs.email != current.inputs.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => debounce(
            () => context.read<RegisterCubit>().updateEmail(
                  Email.dirty(email),
                ),
          ),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.at),
            errorText: state.inputs.email.getErrorText(context),
            hintText: tr(context).register_emailHint,
          ),
        );
      },
    );
  }
}

class _NationalIdField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final debounce = useDebounce();

    return FieldBlocBuilder<RegisterCubit, RegisterInputs>(
      buildWhen: (previous, current) =>
          previous.inputs.nationalId != current.inputs.nationalId,
      builder: (context, state) {
        return TextField(
          onChanged: (nationalId) => debounce(
            () => context.read<RegisterCubit>().updateNationalId(
                  NationalId.dirty(nationalId),
                ),
          ),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.identification_card_1),
            errorText: state.inputs.nationalId.getErrorText(context),
            hintText: tr(context).register_nationalIdHint,
          ),
          keyboardType: TextInputType.number,
        );
      },
    );
  }
}

class _PasswordField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final debounce = useDebounce();

    return FieldBlocBuilder<RegisterCubit, RegisterInputs>(
      buildWhen: (previous, current) =>
          previous.inputs.password != current.inputs.password,
      builder: (context, state) {
        return PasswordTextField(
          onChanged: (password) => debounce(
            () => context.read<RegisterCubit>().updatePassword(
                  Password.dirty(password),
                ),
          ),
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

class _AgreeOnTermsCheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FieldBlocBuilder<RegisterCubit, RegisterInputs>(
      buildWhen: (previous, current) =>
          previous.inputs.agreeOnTermsAndConditions !=
          current.inputs.agreeOnTermsAndConditions,
      builder: (context, state) {
        return CheckboxField(
          value: state.inputs.agreeOnTermsAndConditions.value,
          onChanged: (value) =>
              context.read<RegisterCubit>().updateAgreeOnTermsAndConditions(
                    AgreeOnTermsAndConditions.dirty(value!),
                  ),
          errorText:
              state.inputs.agreeOnTermsAndConditions.getErrorText(context),
          child: RichText(
            text: TextSpan(
              text: '${tr(context).register_agree} ',
              style: const TextStyle(
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${tr(context).register_terms} ',
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                TextSpan(text: '${tr(context).register_and} '),
                TextSpan(
                  text: tr(context).register_privacyPolicy,
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SubmitBlocBuilder<RegisterCubit>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ProgressButton(
          isLoading: state.status.isSubmissionInProgress,
          onPressed: !state.status.isValidated
              ? null
              : () => context.read<RegisterCubit>().submitForm(),
          child: Text(tr(context).register_title),
        );
      },
    );
  }
}
