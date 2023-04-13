class ApiException implements Exception {
  final String cause;
  const ApiException(this.cause);
}
