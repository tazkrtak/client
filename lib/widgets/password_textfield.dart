import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../l10n/tr.dart';

class PasswordTextField extends HookWidget {
  final ValueChanged<String> onChanged;
  final InputDecoration decoration;

  const PasswordTextField({
    required this.onChanged,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final obscureState = useState<bool>(true);
    return TextField(
      obscureText: obscureState.value,
      onChanged: onChanged,
      decoration: decoration.copyWith(
        suffix: GestureDetector(
          onTap: () => obscureState.value = !obscureState.value,
          child: Text(
            obscureState.value
                ? tr(context).widgets_showPassword
                : tr(context).widgets_hidePassword,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
