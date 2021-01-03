import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';

class InputUsername {
  Either<Failure , String> stringToRegisterStringer (String username){
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
  Either<Failure , String> stringToRegisterStringer (String password){
    try{
      if (password == 'test')
        throw FormatException();
      return Right(password);
    }on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
class InputPhoneNumber {
  Either<Failure, int> stringToRegisterStringer(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
class InputEmail {
  Either<Failure , String> stringToRegisterStringer (String email){
    try{
      if (email =='test@test.com')
        throw FormatException();
      return Right(email);
    }on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InputName {
  Either<Failure , String> stringToRegisterStringer (String name){
    try{
      if (name == 'test')
        throw FormatException();
      return Right(name);
    }on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
class InvalidInputFailure extends Failure {}