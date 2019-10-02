import 'package:fchat/data/data_provider/user_data_provider.dart';
import 'package:fchat/data/model/user.dart';

class UserRepository {
  final UserDataProvider _userDataProvider;

  UserRepository(this._userDataProvider);

  Future<FChatUser> getUser() async {
    final rawUser = await _userDataProvider.getUser();
    if (rawUser == null) return null;
    return FChatUser.fromMap(rawUser);
  }

  Future<FChatUser> login({String name}) async {
    final rawUser = await _userDataProvider.login(name: name);
    return FChatUser.fromMap(rawUser);
  }
}
