import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAnswerForRegister extends RegisterEvent {
  final String username;
  final String password;
  final String phonenumber;
  final String email;
  final String name;

  GetAnswerForRegister(
       this.username,
       this.password,
       this.phonenumber,
       this.email,
       this.name);

  @override
  List<Object> get props => [username,password,phonenumber,email,name];
}

