import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/user_location_model.dart';
import '../widgets/user_info_card.dart';

/// Full-screen real-time map view.
///
/// TODO: replace the placeholder canvas with `google_maps_flutter` and feed it
/// [TrackingProvider.currentLocation].
class LiveMapScreen extends StatelessWidget {
  const LiveMapScreen({super.key});

  static const String routeName = '/live-map';

  @override
  Widget build(BuildContext context) {
    final location = UserLocation(
      latitude: 23.8103,
      longitude: 90.4125,
      speed: 8.2,
      batteryLevel: 86,
      isCharging: true,
      updatedAt: DateTime.now(),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Live location')),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: AppColors.mapBackground),
                const Center(
                  child: Icon(
                    Icons.location_on_rounded,
                    size: 64,
                    color: AppColors.primary,
                  ),
                ),
                const Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: _MapPlaceholderBanner(),
                ),
              ],
            ),
          ),
          UserInfoCard(name: 'Ayesha Rahman', location: location),
        ],
      ),
    );
  }
}

class _MapPlaceholderBanner extends StatelessWidget {
  const _MapPlaceholderBanner();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.map_outlined, color: AppColors.primary),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Map preview — connect the Google Maps SDK to go live.',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
