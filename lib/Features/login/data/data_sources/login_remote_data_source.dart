import 'package:flutter/material.dart';
import 'package:login_register_clean_tdd/Features/login/data/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:login_register_clean_tdd/core/error/exceptions.dart';
import 'package:meta/meta.dart';
abstract class LoginRemoteDataSource {
  Future<LoginModel> getAnswer(String username, String password);
      
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;
  LoginRemoteDataSourceImpl({@required this.client});

  @override
  Future<LoginModel> getAnswer(String username, String password) => _getAnswerFromUrl('https://reqres.in/api/users/2');

  Future<LoginModel> _getAnswerFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return LoginModel(out: true);
    } else {
      throw ServerException();
    }
  }

}
