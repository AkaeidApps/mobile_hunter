import 'package:flutter/foundation.dart';

import '../../../core/errors/failures.dart';
import '../data/connection_repository.dart';

/// Manages user search plus the pending and accepted connection lists.
class ConnectionProvider extends ChangeNotifier {
  ConnectionProvider({ConnectionRepository? repository})
    : _repository = repository ?? const ConnectionRepository();

  final ConnectionRepository _repository;

  bool _isLoading = false;
  String? _errorMessage;
  List<ConnectionUser> _searchResults = const [];
  List<ConnectionUser> _pendingRequests = const [];
  List<ConnectionUser> _acceptedConnections = const [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ConnectionUser> get searchResults => _searchResults;
  List<ConnectionUser> get pendingRequests => _pendingRequests;
  List<ConnectionUser> get acceptedConnections => _acceptedConnections;

  Future<void> searchUser(String query) => _run(() async {
    final result = await _repository.searchUser(query);
    _searchResults = result == null ? const [] : [result];
  });

  Future<void> loadPendingRequests(String userId) => _run(() async {
    _pendingRequests = await _repository.fetchPendingRequests(userId);
  });

  Future<void> loadAcceptedConnections(String userId) => _run(() async {
    _acceptedConnections = await _repository.fetchAcceptedConnections(userId);
  });

  Future<bool> sendRequest({
    required String fromUserId,
    required String toUserId,
  }) {
    return _run(() async {
      await _repository.sendRequest(fromUserId: fromUserId, toUserId: toUserId);
    });
  }

  Future<bool> acceptRequest(String requestId) => _run(() async {
    await _repository.respondToRequest(requestId: requestId, accept: true);
    _pendingRequests = _pendingRequests
        .where((user) => user.id != requestId)
        .toList();
  });

  Future<bool> rejectRequest(String requestId) => _run(() async {
    await _repository.respondToRequest(requestId: requestId, accept: false);
    _pendingRequests = _pendingRequests
        .where((user) => user.id != requestId)
        .toList();
  });

  Future<bool> _run(Future<void> Function() action) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await action();
      return true;
    } on Failure catch (failure) {
      _errorMessage = failure.message;
      return false;
    } catch (error) {
      _errorMessage = error.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
