import 'package:flutter/material.dart';

import '../../../tracking/presentation/screens/dashboard_screen.dart';

/// Phone OTP verification screen.
///
/// TODO: connect [_verify] to [AuthProvider.verifyOtp] and show validation
/// errors from the provider.
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  static const String routeName = '/otp';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verify() {
    Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify your number')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter the 6-digit code we sent to your phone.',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _verify(),
              decoration: const InputDecoration(
                labelText: 'OTP code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: _verify,
                child: const Text('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
