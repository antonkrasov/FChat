import 'package:fchat/blocs/login/bloc.dart';
import 'package:fchat/blocs/user/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final loginBloc = LoginBloc(userBloc);

    return BlocListener(
      bloc: userBloc,
      listener: (context, state) {
        if (state is LoggedInUserState) {
          Navigator.of(context).pushNamed('home');
        }
      },
      child: BlocProvider(
        builder: (context) => loginBloc,
        child: Scaffold(
          body: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _nameTextController;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return BlocBuilder(
      bloc: loginBloc,
      builder: (context, state) => _build(state),
    );
  }

  _build(state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Please enter your name',
          ),
          TextField(
            controller: this._nameTextController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'John Dou',
            ),
          ),
          _buildError(state),
          _buildLoginButton(state)
        ],
      ),
    );
  }

  _buildError(state) {
    if (state is ErrorLoginState) {
      final error = state.error;
      return Text('Error: $error');
    }

    return Container();
  }

  _buildLoginButton(state) {
    return RaisedButton(
      color: Color(0xffFC852E),
      child: (state is LoadingLoginState)
          ? CircularProgressIndicator()
          : Text(
              'Login',
            ),
      onPressed: () {
        final loginBloc = BlocProvider.of<LoginBloc>(context);
        final String name = _nameTextController.text;
        loginBloc.dispatch(LoginEvent(name));
      },
    );
  }
}
