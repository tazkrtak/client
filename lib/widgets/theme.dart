import 'package:flutter/material.dart';

class _AppColors {
  static const primary = Color(0xFF09B44D);
  static const accent = Color(0xFF3AC371);
  static const error = Color(0xFFFF0033);
  static const background = Color(0xFFFFFFFF);
  static const inputFill = Color(0xFFEBEDEE);
}

class AppTheme {
  ThemeData get data => ThemeData(
        // Colors
        primaryColor: _AppColors.primary,
        errorColor: _AppColors.error,
        backgroundColor: _AppColors.background,
        accentColor: _AppColors.accent,
        highlightColor: _AppColors.inputFill,

        // Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 24,
            shadowColor: Colors.black54,
            primary: _AppColors.primary,
            onPrimary: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 56,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),

        // Text Field
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          alignLabelWithHint: true,
          fillColor: _AppColors.inputFill,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.all(8),
          hintStyle: const TextStyle(
            color: Colors.black38,
          ),
          errorStyle: const TextStyle(
            color: _AppColors.error,
          ),
          // border: InputBorder.none,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),

        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: _AppColors.accent,
        ),

        // SnackBar
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: _AppColors.accent,
        ),
      );
}
