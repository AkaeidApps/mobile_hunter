import 'permission_service.dart';

/// Keeps sending the device location to Firestore while the app is minimised
/// or closed.
///
/// TODO: implement with `flutter_background_service` + `geolocator` and call
/// [start] after the user signs in and enables sharing.
class BackgroundLocationService {
  BackgroundLocationService({PermissionService? permissionService})
    : _permissionService = permissionService ?? const PermissionService();

  final PermissionService _permissionService;

  bool _isRunning = false;

  bool get isRunning => _isRunning;

  /// Starts the background isolate. Returns `false` when a permission is
  /// missing.
  Future<bool> start() async {
    final granted = await _permissionService.ensureTrackingPermissions();
    if (!granted) return false;

    // TODO: configure and start the background service.
    _isRunning = true;
    return true;
  }

  /// Stops the background isolate.
  Future<void> stop() async {
    // TODO: stop the background service.
    _isRunning = false;
  }
}
