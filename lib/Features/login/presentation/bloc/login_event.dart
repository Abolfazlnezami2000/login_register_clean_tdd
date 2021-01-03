import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAnswerForLogin extends LoginEvent {
  final String username;
  final String password;

  GetAnswerForLogin(this.username,this.password);

  @override
  List<Object> get props => [username,password];
}

