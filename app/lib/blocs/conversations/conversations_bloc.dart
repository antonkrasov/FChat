import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fchat/blocs/user/bloc.dart';
import 'package:fchat/blocs/user/user_bloc.dart';
import 'package:fchat/data/repository/conversations_repository.dart';
import './bloc.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final ConversationsRepository conversationsRepository;
  final UserBloc userBloc;

  StreamSubscription _userStateSubscription;

  ConversationsBloc({this.conversationsRepository, this.userBloc}) {
    _userStateSubscription = userBloc.state.listen((state) {
      if (state is LoggedInUserState) {
        dispatch(LoadConversationsEvent());
      }
    });
  }

  @override
  void dispose() {
    _userStateSubscription.cancel();
    super.dispose();
  }

  @override
  ConversationsState get initialState => LoadingConversationsState();

  @override
  Stream<ConversationsState> mapEventToState(
    ConversationsEvent event,
  ) async* {
    if (event is LoadConversationsEvent) {
      yield* _handleLoadConversationsEvent();
    }
  }

  Stream<ConversationsState> _handleLoadConversationsEvent() async* {
    yield LoadingConversationsState();

    try {
      final conversations = await conversationsRepository.getConversations();
      yield IdleConversationsState(conversations);
    } catch (ex) {
      yield ErrorConversationsState(ex);
    }
  }
}
