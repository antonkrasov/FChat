import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/user.dart';
import 'package:flutter/foundation.dart';

class SendmessageEvent extends Equatable {
  final FChatUser to;
  final String text;

  const SendmessageEvent({@required this.to, @required this.text});

  @override
  List<Object> get props => [];
}