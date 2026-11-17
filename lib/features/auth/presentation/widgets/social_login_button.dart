import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Custom outlined button used for the Gmail and phone sign-in options.
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    required this.label,
    required this.onPressed,
    this.icon = Icons.g_mobiledata_rounded,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 26),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          backgroundColor: AppColors.surface,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
