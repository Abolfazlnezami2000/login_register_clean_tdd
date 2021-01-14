import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/Features/authentication/domain/entities/authentication.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';

abstract class AuthentictionRepository {
  Future<Either<Failure, Authentication>> authenticate(
      String username, String password);
  Future<Either<Failure, Authentication>> persistToken(
      String token);
  Future<Either<Failure, Authentication>> hasToken();
  Future<Either<Failure, Authentication>> deleteToken();
}