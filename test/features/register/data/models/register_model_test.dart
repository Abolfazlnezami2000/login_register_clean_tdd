import 'package:flutter_test/flutter_test.dart';
import 'package:login_register_clean_tdd/Features/register/data/models/register_model.dart';
import 'package:login_register_clean_tdd/Features/register/domain/entities/register.dart';

void main() {
  final testRegister = RegisterModel(out: true);

  test(
    'should be a subclass of Register entity',
    () async {
      // assert
      expect(testRegister, isA<Register>());
    },
  );
}
