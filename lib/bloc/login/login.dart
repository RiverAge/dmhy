import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import 'package:dmhy/event/login/login.dart';
import 'package:dmhy/exception/login.dart';
import 'package:dmhy/repository/login/login_respository.dart';
import 'package:dmhy/state/login/login.dart';

part 'package:dmhy/bloc/login/captcha.dart';
part 'package:dmhy/bloc/login/configure.dart';
part 'package:dmhy/bloc/login/fetch_cookie.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final _sl = GetIt.instance;


  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is ExecLogin) {
      yield Logining();

      try {
        final ret = await _sl<LoginRepository>().authenticate(
            username: event.username,
            password: event.password,
            captcha: event.captcha,
            cookie: event.cookie,
            lockSessionIP: event.lockSessionIP,
            enableSSL: event.enableSSL);
        yield LoginSuccess();
      } on WrongCaptchaException catch (e) {
        yield LoginFailure(
            error: e.toString(), code: LoginFailureCode.WrongCaptcha);
      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    }
  }
}
