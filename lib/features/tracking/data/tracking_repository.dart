import '../../../core/errors/failures.dart';
import 'user_location_model.dart';

/// Reads and writes live location documents in Firestore.
///
/// Each user has exactly one document at `locations/{userId}` that holds their
/// latest [UserLocation]. A trail can optionally be stored in the
/// `users/{userId}/locationHistory` sub-collection.
///
/// TODO: replace the placeholder bodies with `cloud_firestore` calls.
class TrackingRepository {
  const TrackingRepository();

  /// Streams the latest location of [userId].
  Stream<UserLocation> watchLocation(String userId) {
    return Stream<UserLocation>.error(
      const FirestoreFailure('Live location tracking is not configured yet.'),
    );
  }

  /// Pushes a fresh [location] snapshot for [userId].
  Future<void> updateLocation({
    required String userId,
    required UserLocation location,
  }) async {
    throw const FirestoreFailure(
      'Live location tracking is not configured yet.',
    );
  }

  /// Stops sharing the location of [userId].
  Future<void> stopSharing(String userId) async {
    throw const FirestoreFailure(
      'Live location tracking is not configured yet.',
    );
  }
}
