import 'package:flutter/material.dart';
import 'package:login_register_clean_tdd/Features/register/data/models/register_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_register_clean_tdd/core/error/exceptions.dart';
import 'package:meta/meta.dart';
abstract class RegisterRemoteDataSource {
  Future<RegisterModel> getAnswer(String username, String password, String name,
      int phonenumber, String email);
      
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final http.Client client;
  RegisterRemoteDataSourceImpl({@required this.client});

  @override
  Future<RegisterModel> getAnswer(String username, String password, String name,
      int phonenumber, String email) => _getAnswerFromUrl('https://reqres.in/api/users');

  Future<RegisterModel> _getAnswerFromUrl(String url) async {
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        "name": "morpheus",
        "job": "leader"
      }
    );

    if (response.statusCode == 201) {
      return RegisterModel(out: true);
    } else {
      throw ServerException();
    }
  }

}
