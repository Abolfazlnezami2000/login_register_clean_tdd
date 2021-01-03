import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:login_register_clean_tdd/Features/register/domain/entities/register.dart';
import 'package:login_register_clean_tdd/Features/register/domain/use_cases/send_data_register.dart';
import 'package:login_register_clean_tdd/Features/register/presentation/bloc/register_event.dart';
import 'package:login_register_clean_tdd/Features/register/presentation/bloc/register_state.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:login_register_clean_tdd/core/util/register_input.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE_USERNAME = 'Invalid Input Username';
const String INVALID_INPUT_FAILURE_MESSAGE_PASSWORD = 'Invalid Input Password ';
const String INVALID_INPUT_FAILURE_MESSAGE_PHONENUMBER =
    'Invalid Input Phone number';
const String INVALID_INPUT_FAILURE_MESSAGE_EMAIL = 'Invalid Input Email ';
const String INVALID_INPUT_FAILURE_MESSAGE_NAME = 'Invalid Input Name';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final GetAnswer getAnswer;
  final InputUsername inputUsername;
  final InputPassword inputPassword;
  final InputPhoneNumber inputPhoneNumber;
  final InputEmail inputEmail;
  final InputName inputName;

  RegisterBloc({
    @required this.getAnswer,
    @required this.inputUsername,
    @required this.inputPassword,
    @required this.inputPhoneNumber,
    @required this.inputEmail,
    @required this.inputName,
  });

  @override
  RegisterState get initialState => Empty();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    String user;
    String password;
    int phonenumber;
    String email;
    if (event is GetAnswerForRegister) {
      final InputEtherUsername =
          inputUsername.stringToRegisterStringer(event.username);
      final InputEtherPassword =
          inputPassword.stringToRegisterStringer(event.password);
      final InputEtherPhoneNumber =
          inputPhoneNumber.stringToRegisterStringer(event.phonenumber);
      final InputEtherEmail = inputEmail.stringToRegisterStringer(event.email);
      final InputEtherName = inputName.stringToRegisterStringer(event.name);

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
        password = string;
      });
      yield* InputEtherPhoneNumber.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE_PHONENUMBER);
        },
        (integer) async* {
          yield Loading();
          phonenumber = integer;
        },
      );
      yield* InputEtherEmail.fold((Failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE_EMAIL);
      }, (string) async* {
        yield Loading();
        email = string;
      });
      yield* InputEtherName.fold((Failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE_NAME);
      }, (string) async* {
        yield Loading();
        final failureOrRegister =
            await getAnswer(Params(username: user, password: password , phonenumber: phonenumber, email: email , name: string));
        yield* _eitherLoadedOrErrorState(failureOrRegister);
      });
    }
  }

  Stream<RegisterState> _eitherLoadedOrErrorState(
    Either<Failure, Register> failureOrRegister,
  ) async* {
    yield failureOrRegister.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (Register) => Loaded(register: Register),
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
