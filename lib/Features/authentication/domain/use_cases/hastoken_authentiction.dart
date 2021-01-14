import 'package:login_register_clean_tdd/Features/authentication/domain/entities/authentication.dart';
import 'package:login_register_clean_tdd/Features/authentication/domain/repositories/authentication_repository.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:login_register_clean_tdd/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class HasToken implements UseCase<Authentication, NoParams> {
  final AuthentictionRepository repository;

  HasToken(this.repository);

  @override
  Future<Either<Failure, Authentication>> call(NoParams params) async {
    return await repository.hasToken();
  }
}
