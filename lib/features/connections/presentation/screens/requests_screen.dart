import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../widgets/add_user_dialog.dart';

/// Shows incoming connection requests so they can be accepted or rejected.
///
/// TODO: watch [ConnectionProvider.pendingRequests] and render real requests
/// with accept/reject actions.
class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  static const String routeName = '/requests';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connection requests')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AddUserDialog.show(
          context,
          onSearch: (query) =>
              SnackBarHelper.showInfo(context, 'Searching for "$query"...'),
        ),
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('Add user'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inbox_rounded,
                size: 64,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: 16),
              Text(
                'No pending requests yet.',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
