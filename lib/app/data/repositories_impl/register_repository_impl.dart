import 'package:dartz/dartz.dart';
import 'package:test_project/app/api/error/failures.dart';
import 'package:test_project/app/api/remote_datasource.dart';
import 'package:test_project/app/data/models/register_model.dart';
import 'package:test_project/app/data/repositories/register_repository.dart';
import 'package:test_project/app/utils/network_info.dart';

import '../../api/error/exception.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final NetworkInfoImpl networkInfo;
  final RemoteDataSource remoteDataSource;

  RegisterRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Register>> register(
      {required String email, String? password}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.register(email, password);
        if (response.data is Register) {
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
}
