import '../../../core/errors/failures.dart';

/// A user that can be searched for and connected with.
class ConnectionUser {
  const ConnectionUser({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.photoUrl,
  });

  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? photoUrl;

  factory ConnectionUser.fromMap(String id, Map<String, dynamic> map) {
    return ConnectionUser(
      id: id,
      name: map['name'] as String? ?? 'Unknown user',
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      photoUrl: map['photoUrl'] as String?,
    );
  }
}

/// Searches users by email/phone and manages connection requests.
///
/// TODO: replace the placeholder bodies with `cloud_firestore` queries against
/// the collections defined in `FirebaseConstants`.
class ConnectionRepository {
  const ConnectionRepository();

  /// Finds a single user whose email or phone matches [query].
  Future<ConnectionUser?> searchUser(String query) async {
    throw const FirestoreFailure('User search is not configured yet.');
  }

  Future<void> sendRequest({
    required String fromUserId,
    required String toUserId,
  }) async {
    throw const FirestoreFailure('Connection requests are not configured yet.');
  }

  Future<List<ConnectionUser>> fetchPendingRequests(String userId) async {
    throw const FirestoreFailure('Connection requests are not configured yet.');
  }

  Future<List<ConnectionUser>> fetchAcceptedConnections(String userId) async {
    throw const FirestoreFailure('Connections are not configured yet.');
  }

  Future<void> respondToRequest({
    required String requestId,
    required bool accept,
  }) async {
    throw const FirestoreFailure('Connection requests are not configured yet.');
  }
}
