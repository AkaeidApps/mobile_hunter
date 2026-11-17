import '../../../core/errors/failures.dart';

/// Data layer for Google sign-in and phone OTP authentication.
///
/// TODO: initialise Firebase in `main.dart` and replace the placeholder bodies
/// with `firebase_auth` calls.
class AuthRepository {
  const AuthRepository();

  /// Signs in with a Google account and returns the Firebase user id.
  Future<String> signInWithGoogle() async {
    throw const AuthFailure('Google sign-in is not configured yet.');
  }

  /// Sends an OTP to [phoneNumber] and returns the verification id.
  Future<String> sendOtp({required String phoneNumber}) async {
    throw const AuthFailure('Phone OTP is not configured yet.');
  }

  /// Confirms the OTP and returns the Firebase user id.
  Future<String> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    throw const AuthFailure('Phone OTP is not configured yet.');
  }

  Future<void> signOut() async {
    throw const AuthFailure('Sign out is not configured yet.');
  }
}
