import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:login_register_clean_tdd/Features/authentication/domain/entities/authentication.dart';
import 'package:login_register_clean_tdd/Features/authentication/domain/repositories/authentication_repository.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:login_register_clean_tdd/core/usecase/usecase.dart';
import 'package:meta/meta.dart';

class Authenticate implements UseCase<Authentication, Params> {
  final AuthentictionRepository repository;
  Authenticate(this.repository);

  @override
  Future<Either<Failure, Authentication>> call(Params params) async {
    return await repository.authenticate(params.username, params.password);
  }
}

class Params extends Equatable {
  final String username;
  final String password;


  Params(
      {@required this.username,
        @required this.password});

  @override
  List<Object> get props => [username, password];
}