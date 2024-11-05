class AuthException implements Exception {
  AuthException({
    required this.message,
  });

  String message;
}
