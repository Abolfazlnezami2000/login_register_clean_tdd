import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]);
  // TODO: implement props
  List<Object> get props => [props];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
//AppStarted will be dispatched when the Flutter application first loads. It will notify bloc that it needs to determine whether or not there is an existing user.

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({@required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn { token: $token }';

  @override
  // TODO: implement props
  List<Object> get props => [token];
}
//LoggedIn will be dispatched on a successful login. It will notify the bloc that the user has successfully logged in.
class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
//LoggedOut will be dispatched on a successful logout. It will notify the bloc that the user has successfully logged out.