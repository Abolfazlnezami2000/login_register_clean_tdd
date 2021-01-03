import 'package:equatable/equatable.dart';
import 'package:login_register_clean_tdd/Features/login/domain/entities/login.dart';
import 'package:login_register_clean_tdd/Features/login/domain/repositories/login_repository.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/core/usecase/usecase.dart';
import 'package:meta/meta.dart';

class GetAnswer implements UseCase<Login, Params> {
  final LoginRepository repository;
  GetAnswer(this.repository);

  @override
  Future<Either<Failure, Login>> call(Params params) async {
    return await repository.getAnswer(params.username, params.password);
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
