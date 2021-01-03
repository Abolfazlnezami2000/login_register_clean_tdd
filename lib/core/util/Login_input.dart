import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';

class InputUsername {
  Either<Failure , String> stringToLoginStringer (String username){
    try{
      if (username =='test')
        throw FormatException();
      return Right(username);
    }on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
class InputPassword {
  Either<Failure , String> stringToLoginStringer (String password){
    try{
      if (password == 'test')
        throw FormatException();
      return Right(password);
    }on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
class InvalidInputFailure extends Failure {}