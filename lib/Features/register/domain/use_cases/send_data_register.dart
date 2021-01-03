import 'package:equatable/equatable.dart';
import 'package:login_register_clean_tdd/Features/register/domain/entities/register.dart';
import 'package:login_register_clean_tdd/Features/register/domain/repositories/register_repository.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/core/usecase/usecase.dart';
import 'package:meta/meta.dart';

class GetAnswer implements UseCase<Register, Params> {
  final RegisterRepository repository;
  GetAnswer(this.repository);

  @override
  Future<Either<Failure, Register>> call(Params params) async {
    return await repository.getAnswer(params.username, params.password,
        params.name, params.phonenumber, params.email);
  }
}

class Params extends Equatable {
  final String username;
  final String password;
  final int phonenumber;
  final String email;
  final String name;

  Params(
      {@required this.username,
      @required this.password,
      @required this.phonenumber,
      @required this.email,
      @required this.name});

  @override
  List<Object> get props => [username, password, name, email, phonenumber];
}
