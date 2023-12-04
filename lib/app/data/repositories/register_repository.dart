import 'package:dartz/dartz.dart';
import 'package:test_project/app/api/error/failures.dart';
import 'package:test_project/app/data/models/register_model.dart';

abstract class RegisterRepository {
  Future<Either<Failure, Register>> register({
    required String email,
    String? password,
  });
}
