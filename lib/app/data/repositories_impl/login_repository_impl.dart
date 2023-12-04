import 'package:dartz/dartz.dart';
import 'package:test_project/app/api/error/exception.dart';
import 'package:test_project/app/api/error/failures.dart';
import 'package:test_project/app/api/remote_datasource.dart';
import 'package:test_project/app/data/models/login_model.dart';
import 'package:test_project/app/data/repositories/login_repository.dart';
import 'package:test_project/app/utils/network_info.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfoImpl networkInfo;
  final RemoteDataSource remoteDataSource;

  LoginRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Login>> login(
      {required String email, String? password}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.login(email, password);
        if (response.data is Login) {
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
