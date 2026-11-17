/// Base class for all recoverable errors that are surfaced to the UI.
class Failure implements Exception {
  const Failure(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => code == null ? message : '$message (code: $code)';
}

/// Authentication related failure (invalid OTP, cancelled sign-in, ...).
class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.code});
}

/// Failure while reading or writing Firestore data.
class FirestoreFailure extends Failure {
  const FirestoreFailure(super.message, {super.code});
}

/// Device has no internet connection or a request timed out.
class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'No internet connection.', super.code})
    : super(message);
}

/// A required permission was denied by the user.
class PermissionFailure extends Failure {
  const PermissionFailure({
    String message = 'Required permission was denied.',
    super.code,
  }) : super(message);
}

/// Any unexpected error.
class UnknownFailure extends Failure {
  const UnknownFailure({
    String message = 'Something went wrong. Please try again.',
    super.code,
  }) : super(message);
}
