import 'package:login_register_clean_tdd/Features/authentication/domain/entities/authentication.dart';
import 'package:meta/meta.dart';
class AuthenticationModel extends Authentication {
  AuthenticationModel({
    @required String token,
    @required int id,
  }) : super(token: token, id: id);

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      token: json['text'],
      id: (json['number'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
    };
  }
}