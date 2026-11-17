/// Names of the Firestore collections and shared document values.
abstract final class FirebaseConstants {
  static const String usersCollection = 'users';
  static const String locationsCollection = 'locations';
  static const String connectionRequestsCollection = 'connectionRequests';
  static const String connectionsCollection = 'connections';

  /// Sub-collection under a user document that keeps a location trail.
  static const String locationHistorySubcollection = 'locationHistory';

  static const String pendingStatus = 'pending';
  static const String acceptedStatus = 'accepted';
  static const String rejectedStatus = 'rejected';
}
