import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Register extends Equatable {
  final bool out;

  Register(
      {@required this.out});

  @override
  // TODO: implement props
  List<Object> get props => [out];
}
