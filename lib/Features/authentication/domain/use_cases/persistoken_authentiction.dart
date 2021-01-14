import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:login_register_clean_tdd/Features/authentication/domain/entities/authentication.dart';
import 'package:login_register_clean_tdd/Features/authentication/domain/repositories/authentication_repository.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:login_register_clean_tdd/core/usecase/usecase.dart';
import 'package:meta/meta.dart';

class PersistToken implements UseCase<Authentication, Params> {
  final AuthentictionRepository repository;
  PersistToken(this.repository);

  @override
  Future<Either<Failure, Authentication>> call(Params params) async {
    return await repository.persistToken(params.token);
  }
}

class Params extends Equatable {
  final String token;


  Params(
      {@required this.token});

  @override
  List<Object> get props => [token];
}