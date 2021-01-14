import 'package:login_register_clean_tdd/Features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:login_register_clean_tdd/Features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:login_register_clean_tdd/Features/authentication/domain/entities/authentication.dart';
import 'package:login_register_clean_tdd/Features/authentication/domain/repositories/authentication_repository.dart';
import 'package:login_register_clean_tdd/core/error/exceptions.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:login_register_clean_tdd/core/network/network_info.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

typedef Future<Authentication> _ConcreteOrRandomChooser();

class AuthenticationRepositoryImpl implements AuthentictionRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Authentication>> authenticate(String username,
      String password) async {
    return await _getTokenllauthenticate(() {
      return remoteDataSource.gettoken(username, password);
    });
  }

  @override
  Future<Either<Failure, Authentication>> hasToken() async {
    return await _getTokenllhasToken(() {
      return localDataSource.getLastToken();
    });
  }

  @override
  Future<Either<Failure, Authentication>> deleteToken() async {
    // TODO: implement deleteToken
    return await _getTokenlldeleteToken(() {
      return localDataSource.deleteCacheToken();
    });
  }




  Future<Either<Failure, Authentication>> _getTokenllauthenticate(
      _ConcreteOrRandomChooser getConcreteOrRandom,) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteToken = await getConcreteOrRandom();
        localDataSource.cacheToken(remoteToken);
        return Right(remoteToken);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localToken = await localDataSource.getLastToken();
        return Right(localToken);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, Authentication>> _getTokenllhasToken(
      _ConcreteOrRandomChooser getConcreteOrRandom,) async {
    try {
      final localToken = await localDataSource.getLastToken();
      return Right(localToken);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
  Future<Either<Failure, Authentication>> _getTokenlldeleteToken(
      _ConcreteOrRandomChooser getConcreteOrRandom,) async {
    try {
      final localToken = await localDataSource.getLastToken();
      return Right(localToken);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> persistToken(String token) {
    // TODO: implement persistToken
    throw UnimplementedError();
  }
}
