import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/user_location_model.dart';

/// Status card shown under the live map with speed, battery and last update.
class UserInfoCard extends StatelessWidget {
  const UserInfoCard({required this.name, required this.location, super.key});

  final String name;
  final UserLocation location;

  @override
  Widget build(BuildContext context) {
    final updatedAt = MaterialLocalizations.of(context)
        .formatTimeOfDay(TimeOfDay.fromDateTime(location.updatedAt.toLocal()));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _InfoChip(
                icon: Icons.speed_rounded,
                label: '${location.speed.toStringAsFixed(1)} m/s',
              ),
              const SizedBox(width: 12),
              _InfoChip(
                icon: location.isCharging
                    ? Icons.battery_charging_full_rounded
                    : Icons.battery_std_rounded,
                label: location.batteryLevel == null
                    ? 'Battery unknown'
                    : '${location.batteryLevel}% battery',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Updated at $updatedAt',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
