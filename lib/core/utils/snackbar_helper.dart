import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Small helper for showing consistent floating snack bars.
abstract final class SnackBarHelper {
  static void showSuccess(BuildContext context, String message) =>
      _show(context, message, backgroundColor: AppColors.secondary);

  static void showError(BuildContext context, String message) =>
      _show(context, message, backgroundColor: AppColors.danger);

  static void showInfo(BuildContext context, String message) =>
      _show(context, message, backgroundColor: AppColors.textPrimary);

  static void _show(
    BuildContext context,
    String message, {
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
