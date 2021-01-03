import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_clean_tdd/Features/register/presentation/bloc/register_bloc.dart';
import 'package:login_register_clean_tdd/Features/register/presentation/bloc/register_state.dart';
import 'package:login_register_clean_tdd/Features/register/presentation/widgets/register_controls.dart';
import 'package:login_register_clean_tdd/core/widgets/loading_widget.dart';
import 'package:login_register_clean_tdd/core/widgets/message_display.dart';


import '../../../../core/injection_container/login_injection_container.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<RegisterBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<RegisterBloc, RegisterState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start searching!',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    //return TriviaDisplay(numberTrivia: state.login);////////
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              RegisterControls()
            ],
          ),
        ),
      ),
    );
  }
}
