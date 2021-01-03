import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_clean_tdd/Features/login/presentation/bloc/login_bloc.dart';
import 'package:login_register_clean_tdd/Features/login/presentation/bloc/login_event.dart';

class LoginControls extends StatefulWidget {
  const LoginControls({
    Key key,
  }) : super(key: key);

  @override
  _LoginControlsState createState() => _LoginControlsState();
}

class _LoginControlsState extends State<LoginControls> {
  final controller = TextEditingController();
  String inputUsername;
  String inputPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a Username',
          ),
          onChanged: (value) {
            inputUsername = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a Password',
          ),
          onChanged: (value) {
            inputPassword = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text('Login'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchConcrete,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        Expanded(
              child: RaisedButton(
                child: Text('Sing up'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchConcrete,
              ),
            ),
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<LoginBloc>(context)
        .add(GetAnswerForLogin(inputUsername,inputPassword));
  }

  void gotosingup() {
    controller.clear();
   // BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
