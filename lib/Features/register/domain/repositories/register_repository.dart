import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/Features/register/domain/entities/register.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';

abstract class RegisterRepository {
  Future<Either<Failure, Register>> getAnswer(
      String username, String password, String name, int phonenumber, String email);
}