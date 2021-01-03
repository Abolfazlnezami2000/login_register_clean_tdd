import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Login extends Equatable {
  final bool out;

  Login({@required this.out});

  @override
  // TODO: implement props
  List<Object> get props => [out];
}
