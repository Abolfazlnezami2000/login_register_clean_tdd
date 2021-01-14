import 'dart:convert';
import 'package:login_register_clean_tdd/Features/authentication/data/models/authentiction_model.dart';
import 'package:login_register_clean_tdd/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationLocalDataSource {
  /// Gets the cached [AuthenticationModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<AuthenticationModel> getLastToken();

  Future<void> cacheToken(AuthenticationModel tokenToCache);
  Future<void> deleteCacheToken();
}

const CACHED_TOKEN = 'CACHED_NUMBER_TRIVIA';

class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthenticationLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<AuthenticationModel> getLastToken() {
    final jsonString = sharedPreferences.getString(CACHED_TOKEN);
    if (jsonString != null) {
      return Future.value(AuthenticationModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>cacheToken(AuthenticationModel triviaToCache) {
    return sharedPreferences.setString(
      CACHED_TOKEN,
      json.encode(triviaToCache.toJson()),
    );
  }

  @override
  Future<void>deleteCacheToken() {
    return sharedPreferences.setString(
      CACHED_TOKEN,
      null
    );
  }
}
