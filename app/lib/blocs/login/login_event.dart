import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  final String name;

  LoginEvent(this.name);

  @override
  List<Object> get props => [name];
}
