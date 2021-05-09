class ServerException implements Exception {
  final int statusCode;
  final String message;

  ServerException({
    required this.statusCode,
    required this.message,
  });
}
