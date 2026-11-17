import 'package:flutter/foundation.dart';

/// Snapshot of a user's location that is written to Firestore.
@immutable
class UserLocation {
  const UserLocation({
    required this.latitude,
    required this.longitude,
    required this.updatedAt,
    this.speed = 0,
    this.batteryLevel,
    this.isCharging = false,
  });

  final double latitude;
  final double longitude;

  /// Speed in meters per second.
  final double speed;

  /// Battery percentage between 0 and 100, when available.
  final int? batteryLevel;
  final bool isCharging;

  /// When this snapshot was recorded.
  final DateTime updatedAt;

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    final rawUpdatedAt = map['updatedAt'];

    return UserLocation(
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0,
      speed: (map['speed'] as num?)?.toDouble() ?? 0,
      batteryLevel: (map['batteryLevel'] as num?)?.toInt(),
      isCharging: map['isCharging'] as bool? ?? false,
      updatedAt: rawUpdatedAt is DateTime ? rawUpdatedAt : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'latitude': latitude,
    'longitude': longitude,
    'speed': speed,
    'batteryLevel': batteryLevel,
    'isCharging': isCharging,
    'updatedAt': updatedAt,
  };

  UserLocation copyWith({
    double? latitude,
    double? longitude,
    double? speed,
    int? batteryLevel,
    bool? isCharging,
    DateTime? updatedAt,
  }) {
    return UserLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      speed: speed ?? this.speed,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      isCharging: isCharging ?? this.isCharging,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
