import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/Features/login/domain/entities/login.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> getAnswer(
      String username, String password);
}
