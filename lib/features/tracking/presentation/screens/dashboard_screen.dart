import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../connections/presentation/screens/requests_screen.dart';
import 'live_map_screen.dart';

/// Home screen that lists connected users and opens the live map.
///
/// TODO: replace the demo list with [ConnectionProvider.acceptedConnections].
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const String routeName = '/dashboard';

  static const List<_ConnectedUser> _demoUsers = [
    _ConnectedUser(name: 'Ayesha Rahman', status: 'Moving', battery: 86),
    _ConnectedUser(name: 'Rafiul Islam', status: 'Stationary', battery: 54),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Hunter'),
        actions: [
          IconButton(
            tooltip: 'Connection requests',
            onPressed: () =>
                Navigator.of(context).pushNamed(RequestsScreen.routeName),
            icon: const Icon(Icons.people_outline_rounded),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _demoUsers.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final user = _demoUsers[index];

          return Card(
            elevation: 0,
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.border),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: Text(
                  user.name[0],
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(user.status),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${user.battery}%',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              onTap: () =>
                  Navigator.of(context).pushNamed(LiveMapScreen.routeName),
            ),
          );
        },
      ),
    );
  }
}

class _ConnectedUser {
  const _ConnectedUser({
    required this.name,
    required this.status,
    required this.battery,
  });

  final String name;
  final String status;
  final int battery;
}
