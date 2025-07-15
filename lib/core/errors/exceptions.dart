class APIException implements Exception {
  final String errorMessage;
  final int statusCode;

  APIException({required this.errorMessage, required this.statusCode});

  @override
  String toString() {
    return '$statusCode: $errorMessage';
  }
}
