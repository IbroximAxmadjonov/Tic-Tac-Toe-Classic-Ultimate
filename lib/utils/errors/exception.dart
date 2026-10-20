abstract class AppException implements Exception {
  final String message;

  const AppException({required this.message});
}

class ServerException extends AppException {
  final int? statusCode;
  final String? code;
  final Map<String, dynamic>? data;

  const ServerException({
    required super.message,
    this.statusCode,
    this.code,
    this.data,
  });

  @override
  String toString() {
    return 'Server Exception';
  }
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({required super.message});

  @override
  String toString() {
    return 'Unauthorized Exception';
  }
}

class NoInternetException extends AppException {
  const NoInternetException({required super.message});

  @override
  String toString() {
    return 'No Internet Exception';
  }
}

class CacheException extends AppException {
  const CacheException({required super.message});

  @override
  String toString() {
    return 'Cache Exception';
  }
}

class UnknownException extends AppException {
  const UnknownException({required super.message});

  @override
  String toString() {
    return 'Unknown Exception';
  }
}
