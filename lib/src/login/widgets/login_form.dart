import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../api/user/models/models.dart';
import '../../../common/cubits/form_cubit/form_cubit.dart';
import '../../../common/hooks/debounce.dart';
import '../../../l10n/tr.dart';
import '../../../widgets/widgets.dart';
import '../../register/models/models.dart';
import '../../register/register_page.dart';
import '../cubits/login_cubit.dart';
import '../cubits/login_inputs.dart';

class LoginForm extends StatelessWidget {
  final ValueChanged<User> onFormSucces;
  final ValueChanged<String?> onFormFailure;

  const LoginForm({
    required this.onFormSucces,
    required this.onFormFailure,
  });

  @override
  Widget build(BuildContext context) {
    return FieldBlocListener<LoginCubit, LoginInputs, User>(
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
            _NationalIdField(),
            const SizedBox(height: 8),
            _PasswordField(),
            const SizedBox(height: 32),
            _LoginButton(),
            const SizedBox(height: 32),
            _RegisterText(),
          ],
        ),
      ),
    );
  }
}

class _NationalIdField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final debounce = useDebounce();
    final maskFormatter = MaskTextInputFormatter(mask: NationalId.kMaskFormat);

    return FieldBlocBuilder<LoginCubit, LoginInputs>(
      buildWhen: (previous, current) =>
          previous.inputs.nationalId != current.inputs.nationalId,
      builder: (context, state) {
        return TextField(
          inputFormatters: [maskFormatter],
          keyboardType: TextInputType.number,
          onChanged: (_) => debounce(
            () => context.read<LoginCubit>().updateNationalId(
                  NationalId.dirty(maskFormatter.getUnmaskedText()),
                ),
          ),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.identification_card_1),
            errorText: state.inputs.nationalId.getErrorText(context),
            hintText: tr(context).login_nationalIdHint,
          ),
        );
      },
    );
  }
}

class _PasswordField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final debounce = useDebounce();

    return FieldBlocBuilder<LoginCubit, LoginInputs>(
      buildWhen: (previous, current) =>
          previous.inputs.password != current.inputs.password,
      builder: (context, state) {
        return PasswordTextField(
          onChanged: (password) => debounce(
            () => context.read<LoginCubit>().updatePassword(
                  Password.dirty(password),
                ),
          ),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.unlock),
            hintText: tr(context).login_passwordHint,
            errorText: state.inputs.password.getErrorText(context),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SubmitBlocBuilder<LoginCubit>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ProgressButton(
          isLoading: state.status.isSubmissionInProgress,
          onPressed: !state.status.isValidated
              ? null
              : () => context.read<LoginCubit>().submitForm(),
          child: Text(tr(context).login_title),
        );
      },
    );
  }
}

class _RegisterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: tr(context).login_dontHaveAccount,
        style: const TextStyle(
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: tr(context).register_title,
            recognizer: TapGestureRecognizer()
              ..onTap = () => RegisterPage.route(),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
