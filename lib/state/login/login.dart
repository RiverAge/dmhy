import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'package:dmhy/state/login/captcha.dart';
part 'package:dmhy/state/login/configure.dart';
part 'package:dmhy/state/login/fetch_cookie.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class Logining extends LoginState {}

class LoginSuccess extends LoginState {}

enum LoginFailureCode { WrongCaptcha }

class LoginFailure extends LoginState {
  final String error;
  final LoginFailureCode code;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure error $error';

  LoginFailure({@required this.error, this.code});
}
