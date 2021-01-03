import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/Features/login/domain/entities/login.dart';
import 'package:login_register_clean_tdd/Features/login/domain/use_cases/send_data_login.dart';
import 'package:login_register_clean_tdd/Features/login/presentation/bloc/login_bloc.dart';
import 'package:login_register_clean_tdd/Features/login/presentation/bloc/login_State.dart';
import 'package:login_register_clean_tdd/Features/login/presentation/bloc/login_event.dart';
import 'package:login_register_clean_tdd/core/util/Login_input.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';


class MockGetAnswerLogin extends Mock implements GetAnswer {}

class MockInputusername extends Mock implements InputUsername {}

class MockInputpassword extends Mock implements InputPassword {}

void main() {
  LoginBloc bloc;
  MockGetAnswerLogin mockGetAnswerLogin;
  MockInputusername mockInputusername;
  MockInputpassword mockInputpassword;

  setUp(() {
    mockGetAnswerLogin = MockGetAnswerLogin();
    mockInputusername = MockInputusername();
    mockInputpassword = MockInputpassword();

    bloc = LoginBloc(
      mockGetAnswerLogin,
      mockInputusername,
      mockInputpassword,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetAnswerForLogin', () {
    final tusername = 'username';
    final tusernameParsed = 'test';
    final tpassword = 'password';
    final tpasswordParsed = 'test';
    final tLogin = Login(out: true);

    void setUpMockInputUserNameSuccess() =>
        when(mockInputusername.stringToLoginStringer(any))
            .thenReturn(Right(tusernameParsed));
    void setUpMockInputPassWordSuccess() =>
        when(mockInputpassword.stringToLoginStringer(any))
            .thenReturn(Right(tpasswordParsed));
    test(
      'should call the Inputusename  to validate and invalid input value',
      () async {
        // arrange
        setUpMockInputUserNameSuccess();
        // act
        bloc.add(GetAnswerForLogin(tusername, tpassword));
        await untilCalled(mockInputusername.stringToLoginStringer(any));
        // assert
        verify(mockInputusername.stringToLoginStringer(tusername));
      },
    );
    test(
      'should call the Inputpassword to validate and invalid input value',
      () async {
        // arrange
        setUpMockInputPassWordSuccess();
        // act
        bloc.add(GetAnswerForLogin(tusername, tpassword));
        await untilCalled(mockInputpassword.stringToLoginStringer(any));
        // assert
        verify(mockInputpassword.stringToLoginStringer(tpassword));
      },
    );

    test(
      'should emit [Error] when the input is invalid in username',
      () async {
        // arrange
        when(mockInputusername.stringToLoginStringer(any))
            .thenReturn(Left(InvalidInputFailure()));
        // assert later
        final expected = [
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE_USERNAME),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetAnswerForLogin(tusername, tpassword));
      },
    );
    test(
      'should emit [Error] when the input is invalid in password',
      () async {
        // arrange
        when(mockInputpassword.stringToLoginStringer(any))
            .thenReturn(Left(InvalidInputFailure()));
        // assert later
        final expected = [
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE_PASSWORD),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetAnswerForLogin(tusername, tpassword));
      },
    );
    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        setUpMockInputUserNameSuccess();
        setUpMockInputPassWordSuccess();
        //when(MockGetAnswerLogin(any)).thenAnswer((_) async => Right(tLogin));
        // act
        bloc.add(GetAnswerForLogin(tusername, tpassword));
        await untilCalled(MockGetAnswerLogin());
        // assert
        //verify(MockGetAnswerLogin(Params(username: tusernameParsed,password: tpasswordParsed));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputUserNameSuccess();
        setUpMockInputPassWordSuccess();
       // when(MockGetAnswerLogin(any)).thenAnswer((_) async => Right(tLogin));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(login: tLogin),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetAnswerForLogin(tusername, tpassword));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        setUpMockInputUserNameSuccess();
        setUpMockInputPassWordSuccess();
        //when(MockGetAnswerLogin(any)).thenAnswer((_) async => Right(tLogin));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetAnswerForLogin(tusername, tpassword));
      },
    );
  });
}
