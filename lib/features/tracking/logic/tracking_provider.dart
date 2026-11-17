import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/errors/failures.dart';
import '../data/tracking_repository.dart';
import '../data/user_location_model.dart';

/// Streams the live location of the selected user and exposes map state.
///
/// Can be provided with Riverpod or Provider from `app.dart` once a state
/// management package is added.
class TrackingProvider extends ChangeNotifier {
  TrackingProvider({TrackingRepository? repository})
    : _repository = repository ?? const TrackingRepository();

  final TrackingRepository _repository;

  StreamSubscription<UserLocation>? _locationSubscription;
  UserLocation? _currentLocation;
  String? _selectedUserId;
  String? _errorMessage;

  UserLocation? get currentLocation => _currentLocation;
  String? get selectedUserId => _selectedUserId;
  String? get errorMessage => _errorMessage;
  bool get isTracking => _locationSubscription != null;

  /// Starts listening to the location of [userId].
  void startTracking(String userId) {
    if (_selectedUserId == userId && _locationSubscription != null) return;

    stopTracking();
    _selectedUserId = userId;
    _errorMessage = null;

    _locationSubscription = _repository
        .watchLocation(userId)
        .listen(
          (location) {
            _currentLocation = location;
            notifyListeners();
          },
          onError: (Object error) {
            _errorMessage = error is Failure ? error.message : error.toString();
            notifyListeners();
          },
        );

    notifyListeners();
  }

  void stopTracking() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
    _selectedUserId = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }
}
