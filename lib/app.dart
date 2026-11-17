import 'package:flutter/material.dart';

import 'core/constants/app_colors.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/otp_screen.dart';
import 'features/connections/presentation/screens/requests_screen.dart';
import 'features/tracking/presentation/screens/dashboard_screen.dart';
import 'features/tracking/presentation/screens/live_map_screen.dart';

/// Root widget of the app: theme, routing and global configuration live here.
class MobileHunterApp extends StatelessWidget {
  const MobileHunterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Hunter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        OtpScreen.routeName: (_) => const OtpScreen(),
        DashboardScreen.routeName: (_) => const DashboardScreen(),
        LiveMapScreen.routeName: (_) => const LiveMapScreen(),
        RequestsScreen.routeName: (_) => const RequestsScreen(),
      },
    );
  }
}
