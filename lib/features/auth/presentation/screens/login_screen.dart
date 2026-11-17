import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../widgets/social_login_button.dart';
import 'otp_screen.dart';

/// Entry screen with Google login and phone-number OTP login.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.my_location_rounded,
                  color: AppColors.surface,
                  size: 36,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Mobile Hunter',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Stay connected with the people who matter and follow them on '
                'the map in real time.',
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
              ),
              const Spacer(),
              SocialLoginButton(
                label: 'Continue with Gmail',
                onPressed: () => SnackBarHelper.showInfo(
                  context,
                  'Google sign-in will be available after Firebase setup.',
                ),
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                label: 'Continue with phone number',
                icon: Icons.phone_rounded,
                onPressed: () =>
                    Navigator.of(context).pushNamed(OtpScreen.routeName),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'By continuing you agree to our Terms & Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
