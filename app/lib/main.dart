import 'package:fchat/blocs/conversations/bloc.dart';
import 'package:fchat/blocs/simple_bloc_delegate.dart';
import 'package:fchat/blocs/user/bloc.dart';
import 'package:fchat/data/data_provider/conversations_data_provider.dart';
import 'package:fchat/data/data_provider/impl/firebase_conversations_data_provider.dart';
import 'package:fchat/data/data_provider/impl/firebase_user_data_provider.dart';
import 'package:fchat/data/data_provider/user_data_provider.dart';
import 'package:fchat/data/repository/conversations_repository.dart';
import 'package:fchat/data/repository/user_repository.dart';
import 'package:fchat/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserDataProvider userDataProvider = FirebaseUserDataProvider();
    final UserRepository userRepository = UserRepository(userDataProvider);

    final UserBloc userBloc = UserBloc(userRepository)
      ..dispatch(AppStartedEvent());

    final ConversationsDataProvider conversationsDataProvider =
        FirebaseConversationsDataProvider();
    final ConversationsRepository conversationsRepository =
        ConversationsRepository(conversationsDataProvider);

    final ConversationsBloc conversationsBloc = ConversationsBloc(
      conversationsRepository: conversationsRepository,
      userBloc: userBloc,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          builder: (context) => userBloc,
        ),
        BlocProvider<ConversationsBloc>(
          builder: (context) => conversationsBloc,
        ),
      ],
      child: MaterialApp(
        title: 'FChat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Router.generateRoute,
        initialRoute: 'splash',
      ),
    );
  }
}
