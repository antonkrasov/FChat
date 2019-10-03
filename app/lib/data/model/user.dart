import 'package:equatable/equatable.dart';

class FChatUser extends Equatable {
  final String id;
  final String name;

  FChatUser({this.id, this.name});

  @override
  List<Object> get props => [id, name];

  factory FChatUser.fromMap(Map rawUser) {
    return FChatUser(
      id: rawUser['id'],
      name: rawUser['name'],
    );
  }

  @override
  String toString() {
  return 'FChatUser{$name}';
   }
}
