abstract class UserDataProvider {
  Future<Map> getUser();

  Future<Map> login({String name});
}
