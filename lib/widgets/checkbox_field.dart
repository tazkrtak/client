import 'package:flutter/material.dart';

class CheckboxField extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Widget child;
  final String? errorText;

  const CheckboxField({
    required this.value,
    required this.onChanged,
    required this.child,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              child,
              if (errorText != null && errorText!.isNotEmpty) ...{
                Text(
                  errorText ?? '',
                  style: Theme.of(context).inputDecorationTheme.errorStyle,
                ),
              }
            ],
          ),
        )
      ],
    );
  }
}
