import 'dart:convert';
import 'package:login_register_clean_tdd/Features/authentication/data/models/authentiction_model.dart';
import 'package:login_register_clean_tdd/Features/authentication/domain/entities/authentication.dart';
import 'package:login_register_clean_tdd/core/error/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<Authentication> gettoken(String username, String password);
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final http.Client client;

  AuthenticationRemoteDataSourceImpl({@required this.client});

  @override
  Future<Authentication> gettoken(String username, String password) async {
    String url = 'https://reqres.in/api/register';

    final response = await client.post(url, headers: {
      'Content-Type': 'application/json',
    }, body: {
      "email": username,
      "password": password
    });

    if (response.statusCode == 200) {
      return AuthenticationModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
