import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fchat/data/model/user.dart';
import 'package:fchat/data/repository/user_repository.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository);

  @override
  UserState get initialState => UninitializedUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is AppStartedEvent) {
      yield* _handleAppStartedEvent();
    } else if (event is LoggedInEvent) {
      yield* _handleLoggedInEvent(event);
    }
  }

  Stream<UserState> _handleAppStartedEvent() async* {
    final currentUser = await userRepository.getUser();
    if (currentUser == null) {
      yield LoginRequiredUserState();
    } else {
      yield LoggedInUserState(currentUser);
    }
  }

  Stream<UserState> _handleLoggedInEvent(LoggedInEvent event) async* {
    yield LoggedInUserState(event.fChatUser);
  }

  FChatUser getCurrentUser() {
    final state = currentState;
    if (state is LoggedInUserState) {
      return state.fChatUser;
    }

    return null;
  }
}
