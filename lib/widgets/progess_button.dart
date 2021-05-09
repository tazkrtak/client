import 'package:flutter/material.dart';

class ProgressButton extends ElevatedButton {
  const ProgressButton({
    bool isLoading = false,
    required Widget child,
    required VoidCallback? onPressed,
  }) : super(
          onPressed: onPressed,
          child: isLoading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : child,
        );
}
