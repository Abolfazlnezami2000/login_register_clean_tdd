import 'package:equatable/equatable.dart';
import 'package:login_register_clean_tdd/Features/login/domain/entities/login.dart';
import 'package:login_register_clean_tdd/Features/register/domain/entities/register.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends RegisterState {}

class Loading extends RegisterState {}

class Loaded extends RegisterState {
  final Register register;

  Loaded({@required this.register});

  @override
  List<Object> get props => [register];
}

class Error extends RegisterState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
