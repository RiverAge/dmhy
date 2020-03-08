import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticateEvent {
  final String token;
  final String uid;

  LoggedIn({@required this.token, @required this.uid})
      : assert(token != null),
        assert(uid != null);
}

class Loggout extends AuthenticateEvent {}
