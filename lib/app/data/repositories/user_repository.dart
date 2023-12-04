import 'package:dartz/dartz.dart';
import 'package:test_project/app/api/error/failures.dart';
import 'package:test_project/app/data/models/update_user_model.dart';
import 'package:test_project/app/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers(int? page);
  Future<Either<Failure, User>> getUser(int id);
  Future<Either<Failure, UpdateUser>> updateUser(int id, UpdateUser updateUser);
  Future<Either<Failure, User>> createUser(User user);
  Future<Either<Failure, String>> deleteUser(int id);
}
