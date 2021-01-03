import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_register_clean_tdd/Features/register/domain/entities/register.dart';
import 'package:login_register_clean_tdd/Features/register/domain/repositories/register_repository.dart';
import 'package:login_register_clean_tdd/Features/register/domain/use_cases/send_data_register.dart';
import 'package:mockito/mockito.dart';

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  GetAnswer usecase;
  MockRegisterRepository mockRegisterRepository;

  setUp(() {
    mockRegisterRepository = MockRegisterRepository();
    usecase = GetAnswer(mockRegisterRepository);
  });

  final String usernametest = 'test';
  final String passwordtest = 'test';
  final int phonenumbertest = 1234567890;
  final String emailtest = 'test@test.com';
  final String nametest = 'test';
  final giveanswer = Register(out: true);

  test(
    'should get answer for the username and password from the repository',
    () async {
      // arrange
      when(mockRegisterRepository.getAnswer(any, any, any, any, any))
          .thenAnswer((_) async => Right(giveanswer));
      // act
      final result = await usecase(Params(
          username: usernametest,
          password: passwordtest,
          phonenumber: phonenumbertest,
          email: emailtest,
          name: nametest));
      // assert
      expect(result, Right(giveanswer));
      verify(mockRegisterRepository.getAnswer(
          usernametest, passwordtest, nametest, phonenumbertest, emailtest));
      verifyNoMoreInteractions(mockRegisterRepository);
    },
  );
}
