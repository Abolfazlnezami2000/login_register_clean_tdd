import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/Features/login/domain/entities/login.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:login_register_clean_tdd/core/util/Login_input.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:login_register_clean_tdd/Features/login/domain/use_cases/send_data_login.dart';
import 'package:login_register_clean_tdd/Features/login/presentation/bloc/login_event.dart';
import 'package:login_register_clean_tdd/Features/login/presentation/bloc/login_State.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE_USERNAME = 'Invalid Input Username';
const String INVALID_INPUT_FAILURE_MESSAGE_PASSWORD = 'Invalid Input Password ';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetAnswer getAnswer;
  final InputUsername inputUsername;
  final InputPassword inputPassword;

  LoginBloc({
    @required this.getAnswer,
    @required this.inputUsername,
    @required this.inputPassword,
  });

  @override
  LoginState get initialState => Empty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    String user;
    if (event is GetAnswerForLogin) {
      final InputEtherUsername =
          inputUsername.stringToLoginStringer(event.username);
      final InputEtherPassword =
          inputPassword.stringToLoginStringer(event.password);

      yield* InputEtherUsername.fold((Failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE_USERNAME);
      }, (string) async* {
        yield Loading();
        user = string;
      });
      yield* InputEtherPassword.fold((Failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE_PASSWORD);
      }, (string) async* {
        yield Loading();
        final failureOrLogin =
            await getAnswer(Params(username: user, password: string));
        yield* _eitherLoadedOrErrorState(failureOrLogin);
      });
    }
  }

  Stream<LoginState> _eitherLoadedOrErrorState(
    Either<Failure, Login> failureOrLogin,
  ) async* {
    yield failureOrLogin.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (Login) => Loaded(login: Login),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
