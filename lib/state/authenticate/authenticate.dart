import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticateState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticateState {}

class AuthenticationAuthenticated extends AuthenticateState {
  final String token;
  final String uid;
  @override
  List<Object> get props => [token, uid];

  AuthenticationAuthenticated({@required this.token, @required this.uid});
}

class AuthenticationUnauthenticated extends AuthenticateState {}
