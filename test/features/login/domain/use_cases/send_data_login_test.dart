
import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/Features/login/domain/repositories/login_repository.dart';
import 'package:login_register_clean_tdd/Features/login/domain/use_cases/send_data_login.dart';
import 'package:login_register_clean_tdd/Features/login/domain/entities/login.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLoginRepository extends Mock
    implements LoginRepository {}

void main() {
  GetAnswer usecase;
  MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = GetAnswer(mockLoginRepository);
  });

  final usernametest = 'test';
  final passwordtest = 'test';
  final giveanswer = Login(out: true);

  test(
    'should get answer for the username and password from the repository',
    () async {
      // arrange
      when(mockLoginRepository.getAnswer(any,any))
          .thenAnswer((_) async => Right(giveanswer));
      // act
      final result = await usecase(Params(username: usernametest , password: passwordtest));
      // assert
      expect(result, Right(giveanswer));
      verify(mockLoginRepository.getAnswer(usernametest,passwordtest));
      verifyNoMoreInteractions(mockLoginRepository);
    },
  );
}