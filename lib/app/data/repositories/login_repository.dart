import '../../api/error/failures.dart';
import '../models/login_model.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> login({
    required String email,
    String? password,
  });
}
