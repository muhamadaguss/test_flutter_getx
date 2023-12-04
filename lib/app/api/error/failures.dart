import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure([this.message]);

  @override
  List<String?> get props => [message];

  @override
  String toString() {
    return message ?? 'Pesan tidak dikenal';
  }
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Pesan tidak dikenal']);

  @override
  String toString() {
    return super.message ?? 'Pesan tidak dikenal';
  }
}

class CustomFailure extends Failure {
  const CustomFailure([super.message = 'Pesan tidak dikenal']);

  @override
  String toString() {
    return super.message ?? 'Pesan tidak dikenal';
  }
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Pesan tidak dikenal']);

  @override
  String toString() {
    return super.message ?? 'Pesan tidak dikenal';
  }
}
