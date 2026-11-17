/// Centralised runtime-permission handling for GPS and background location.
///
/// Add `geolocator` / `permission_handler` to `pubspec.yaml`, then replace the
/// TODO bodies below with the plugin calls.
class PermissionService {
  const PermissionService();

  /// Whether the device location service (GPS) is turned on.
  Future<bool> isLocationServiceEnabled() async {
    // TODO: return Geolocator.isLocationServiceEnabled();
    return false;
  }

  /// Requests location access while the app is in use.
  Future<bool> requestForegroundLocationPermission() async {
    // TODO: request `LocationPermission.whileInUse`.
    return false;
  }

  /// Requests the "always allow" permission needed for background tracking.
  Future<bool> requestBackgroundLocationPermission() async {
    // TODO: request `LocationPermission.always`.
    return false;
  }

  /// Chains all checks above and returns `true` only when everything is ready.
  Future<bool> ensureTrackingPermissions() async {
    // TODO: implement the actual permission flow.
    return false;
  }
}
