import 'package:fchat/blocs/user/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener(
      bloc: userBloc,
      listener: (context, state) {
        if (state is LoggedInUserState) {
          Navigator.of(context).pushReplacementNamed('home');
        } else if (state is LoginRequiredUserState) {
          Navigator.of(context).pushReplacementNamed('login');
        }
      },
      child: Scaffold(
        body: Center(
          child: Center(
            child: Image.asset('assets/splash_logo.png'),
          ),
        ),
      ),
    );
  }
}
