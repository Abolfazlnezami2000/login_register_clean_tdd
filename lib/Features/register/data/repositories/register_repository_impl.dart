import 'package:login_register_clean_tdd/Features/register/data/data_sources/register_remote_data_source.dart';
import 'package:login_register_clean_tdd/Features/register/domain/entities/register.dart';
import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/Features/register/domain/repositories/register_repository.dart';
import 'package:login_register_clean_tdd/core/error/exceptions.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:login_register_clean_tdd/core/network/network_info.dart';
import 'package:meta/meta.dart';

typedef Future<Register> _ConcreteOrRandomChooser();

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RegisterRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Register>> getAnswer(String username, String password,
      String name, int phonenumber, String email) async {
    return await _getAnswer(() {
      return remoteDataSource.getAnswer(username,password,name,phonenumber,email);
    });
  }


  Future<Either<Failure, Register>> _getAnswer(
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
