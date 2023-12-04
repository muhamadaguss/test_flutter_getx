class ServerException implements Exception {
  final String message;
  final int responseCode;
  ServerException([this.message = 'Pesan tidak dikenal', this.responseCode = 500]);

  @override
  String toString() {
    return message;
  }
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Pesan tidak dikenal']);

  @override
  String toString() {
    return message;
  }
}
