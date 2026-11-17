import 'package:flutter/foundation.dart';

import '../../../core/errors/failures.dart';
import '../data/auth_repository.dart';

/// Holds the authentication state of the current session.
///
/// Can be provided with Riverpod or Provider from `app.dart` once a state
/// management package is added.
class AuthProvider extends ChangeNotifier {
  AuthProvider({AuthRepository? repository})
    : _repository = repository ?? const AuthRepository();

  final AuthRepository _repository;

  bool _isLoading = false;
  String? _userId;
  String? _verificationId;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isSignedIn => _userId != null;
  String? get userId => _userId;
  String? get errorMessage => _errorMessage;

  Future<bool> signInWithGoogle() {
    return _run(() async {
      _userId = await _repository.signInWithGoogle();
      return true;
    });
  }

  Future<bool> sendOtp(String phoneNumber) {
    return _run(() async {
      _verificationId = await _repository.sendOtp(phoneNumber: phoneNumber);
      return true;
    });
  }

  Future<bool> verifyOtp(String smsCode) async {
    final verificationId = _verificationId;
    if (verificationId == null) {
      _errorMessage = 'No OTP was requested yet.';
      notifyListeners();
      return false;
    }

    return _run(() async {
      _userId = await _repository.verifyOtp(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return true;
    });
  }

  Future<void> signOut() async {
    await _run(() async {
      await _repository.signOut();
      _userId = null;
      _verificationId = null;
      return true;
    });
  }

  Future<bool> _run(Future<bool> Function() action) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      return await action();
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
