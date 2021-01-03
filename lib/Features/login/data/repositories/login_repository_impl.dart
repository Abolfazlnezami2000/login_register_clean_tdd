import 'package:login_register_clean_tdd/Features/login/data/data_sources/login_remote_data_source.dart';
import 'package:login_register_clean_tdd/Features/login/domain/entities/login.dart';
import 'package:login_register_clean_tdd/Features/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/core/error/exceptions.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:login_register_clean_tdd/core/network/network_info.dart';
import 'package:meta/meta.dart';

typedef Future<Login> _ConcreteOrRandomChooser();

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Login>> getAnswer(String username, String password) async {
    return await _getAnswer(() {
      return remoteDataSource.getAnswer(username,password);
    });
  }


  Future<Either<Failure, Login>> _getAnswer(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final answer = await getConcreteOrRandom();
        return Right(answer);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      throw ServerFailure();
    }
  }
}
