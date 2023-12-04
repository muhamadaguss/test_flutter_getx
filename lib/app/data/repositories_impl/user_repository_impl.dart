import 'package:dartz/dartz.dart';
import 'package:test_project/app/api/error/exception.dart';
import 'package:test_project/app/api/error/failures.dart';
import 'package:test_project/app/api/remote_datasource.dart';
import 'package:test_project/app/data/models/update_user_model.dart';
import 'package:test_project/app/data/models/user_model.dart';
import 'package:test_project/app/data/repositories/user_repository.dart';
import 'package:test_project/app/utils/network_info.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfoImpl networkInfo;
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<User>>> getUsers(int? page) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getUsers(page);
        if (response.data is List<User>) {
          return Right(response.data);
        } else {
          return const Left(ServerFailure());
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(
        ServerFailure('Tidak ada koneksi internet'),
      );
    }
  }

  @override
  Future<Either<Failure, User>> getUser(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getUser(id);
        if (response.data is User) {
          return Right(response.data);
        } else {
          return const Left(ServerFailure());
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(
        ServerFailure('Tidak ada koneksi internet'),
      );
    }
  }

  @override
  Future<Either<Failure, UpdateUser>> updateUser(
      int id, UpdateUser updateUser) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.updateUser(id, updateUser);
        if (response.data is UpdateUser) {
          return Right(response.data);
        } else {
          return const Left(ServerFailure());
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(
        ServerFailure('Tidak ada koneksi internet'),
      );
    }
  }

  @override
  Future<Either<Failure, User>> createUser(User user) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.createUser(user);
        if (response.data is User) {
          return Right(response.data);
        } else {
          return const Left(ServerFailure());
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(
        ServerFailure('Tidak ada koneksi internet'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> deleteUser(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.deleteUser(id);
        if (response.message == "Success") {
          return Right(response.message);
        } else {
          return const Left(ServerFailure());
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(
        ServerFailure('Tidak ada koneksi internet'),
      );
    }
  }
}
