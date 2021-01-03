import 'package:flutter_test/flutter_test.dart';
import 'package:login_register_clean_tdd/Features/login/data/models/login_model.dart';
import 'package:login_register_clean_tdd/Features/login/domain/entities/login.dart';


void main() {
  final testLogin = LoginModel(out: true);

  test(
    'should be a subclass of Register entity',
    () async {
      // assert
      expect(testLogin, isA<Login>());
    },
  );
}
