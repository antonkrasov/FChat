import 'package:fchat/blocs/user/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocBuilder(
      bloc: userBloc,
      builder: (context, state) => _build(state),
    );
  }

  _build(state) {
    if (state is LoggedInUserState) {
      final user = state.fChatUser;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                CupertinoIcons.profile_circled,
                size: 120,
                color: Colors.black.withOpacity(0.3),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                user.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      );
    }
  }
}
