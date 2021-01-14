part of 'auth_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}
//uninitialized — waiting to see if the user is authenticated or not on app start.

class AuthenticationAuthenticated extends AuthenticationState {}
//authenticated — successfully authenticated

class AuthenticationUnauthenticated extends AuthenticationState {}
//unauthenticated — not authenticated

class AuthenticationLoading extends AuthenticationState {}

//loading — waiting to persist/delete a token