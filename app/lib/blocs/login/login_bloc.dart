import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fchat/blocs/user/bloc.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserBloc userBloc;

  LoginBloc(this.userBloc);

  @override
  LoginState get initialState => IdleLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield LoadingLoginState();

    try {
      final userRepo = userBloc.userRepository;
      final user = await userRepo.login(name: event.name);

      userBloc.dispatch(LoggedInEvent(user));
    } catch (ex) {
      yield ErrorLoginState(ex);
    }
  }
}
