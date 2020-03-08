import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'package:dmhy/event/login/configure.dart';
part 'package:dmhy/event/login/captcha.dart';
part 'package:dmhy/event/login/fetch_cookie.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class ExecLogin extends LoginEvent {
  final String username;
  final String password;
  final String captcha;
  final bool enableSSL;
  final bool lockSessionIP;
  final String cookie;

  @override
  List<Object> get props => [username, password, captcha];

  @override
  String toString() =>
      'ExecLogin username $username, password $password, captcha $captcha';

  ExecLogin(
      {@required this.username,
      @required this.password,
      @required this.captcha,
      @required this.enableSSL,
      @required this.lockSessionIP,
      @required this.cookie})
      : assert(username != null),
        assert(password != null),
        assert(captcha != null),
        assert(enableSSL != null),
        assert(lockSessionIP != null),
        assert(cookie != null);
}
