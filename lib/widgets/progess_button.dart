import 'package:flutter/material.dart';

class ProgressButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final Widget child;

  const ProgressButton({
    this.isLoading = false,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      // [IgnorePointer] is used to prevent interactions,
      // instead of setting [onPressed] to null,
      // to avoid glitches on changing [isLoading]'s value.
      ignoring: isLoading,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .foregroundColor!
                        .resolve({MaterialState.pressed})!,
                  ),
                ),
              )
            : child,
      ),
    );
  }
}
