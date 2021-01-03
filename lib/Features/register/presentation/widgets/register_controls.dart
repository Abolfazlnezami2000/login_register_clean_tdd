import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_clean_tdd/Features/register/presentation/bloc/register_bloc.dart';
import 'package:login_register_clean_tdd/Features/register/presentation/bloc/register_event.dart';

class RegisterControls extends StatefulWidget {
  const RegisterControls({
    Key key,
  }) : super(key: key);

  @override
  _RegisterControlsState createState() => _RegisterControlsState();
}

class _RegisterControlsState extends State<RegisterControls> {
  final controller = TextEditingController();
  String inputUsername;
  String inputPassword;
  String inputPhonenumber;
  String inputEmail;
  String inputName;

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
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a Phone Number',
          ),
          onChanged: (value) {
            inputPhonenumber = value;
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
            hintText: 'Input a Email',
          ),
          onChanged: (value) {
            inputEmail = value;
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
            hintText: 'Input a Name',
          ),
          onChanged: (value) {
            inputName = value;
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
                child: Text('Register'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchConcrete,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<RegisterBloc>(context)
        .add(GetAnswerForRegister(inputUsername,inputPassword,inputPhonenumber,inputEmail,inputName));
  }
}
