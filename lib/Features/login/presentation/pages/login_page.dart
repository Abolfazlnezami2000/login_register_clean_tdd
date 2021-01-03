import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_clean_tdd/Features/login/presentation/bloc/login_bloc.dart';
import 'package:login_register_clean_tdd/Features/login/presentation/bloc/login_state.dart';
import 'package:login_register_clean_tdd/Features/login/presentation/widgets/login_controls.dart';
import 'package:login_register_clean_tdd/core/widgets/loading_widget.dart';
import 'package:login_register_clean_tdd/core/widgets/message_display.dart';

import '../../../../core/injection_container/login_injection_container.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<LoginBloc, LoginState>(
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
              LoginControls()
            ],
          ),
        ),
      ),
    );
  }
}
