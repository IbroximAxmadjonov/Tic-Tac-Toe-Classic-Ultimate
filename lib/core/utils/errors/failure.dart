import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;
  final String? code;
  final Map<String, dynamic>? data;

  const ServerFailure({
    required super.message,
    this.statusCode,
    this.code,
    this.data,
  });

  @override
  List<Object?> get props => [message, statusCode, code, data];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({required super.message});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message});
}
