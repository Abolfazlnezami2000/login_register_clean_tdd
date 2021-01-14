import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


class Authentication extends Equatable {
  final String token;
  final int id;

  Authentication({@required this.token,@required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [token,id];
}