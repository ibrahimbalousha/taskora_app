   class OfflineException implements Exception{}
class ServerException implements Exception {
  final dynamic message;
  ServerException(this.message);
}