
import 'package:dmhy/bloc/login/login.dart';
import 'package:dmhy/event/login/login.dart';

import 'package:dmhy/state/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(providers: [
        BlocProvider<CaptchaBloc>(
          create: (context) => CaptchaBloc(),
        ),
        BlocProvider<FetchCookieBloc>(
          create: (context) => FetchCookieBloc(
              captchaBloc: BlocProvider.of<CaptchaBloc>(context))
            ..add(Fetch()),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<ConfigureBloc>(
          create: (context) => ConfigureBloc(),
        ),
      ], child: LoginForm());
}

class LoginForm extends StatelessWidget {
  final _usernameController =
      TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _captchaController = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocBuilder<CaptchaBloc,
          CaptchaState>(
      builder: (context, captchaState) => BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              BlocProvider.of<CaptchaBloc>(context).add(Refresh());
            }
          },
          builder: (context, state) =>
              BlocBuilder<FetchCookieBloc, FetchCookieState>(
                  builder: (context, cookieState) => Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Account Id(Email Address)'),
                            controller: _usernameController,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Password'),
                            obscureText: true,
                            controller: _passwordController,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                  child: TextFormField(
                                decoration:
                                    InputDecoration(hintText: 'CAPTCHA'),
                                controller: _captchaController,
                              )),
                              captchaState is CaptchaRefreshed &&
                                      cookieState is CookieLoaded
                                  ? FlatButton(
                                      onPressed: () =>
                                          BlocProvider.of<CaptchaBloc>(context)
                                              .add(Refresh()),
                                      child: Image.network(
                                        captchaState.uri,
                                        headers: {'cookie': cookieState.cookie},
                                      ))
                                  : SizedBox.shrink(),
                            ],
                          ),
                          _Configuration(),
                          BlocBuilder<ConfigureBloc, ConfigureState>(
                            builder: (context, configureState) => RaisedButton(
                              onPressed: () => cookieState is CookieLoaded
                                  ? BlocProvider.of<LoginBloc>(context).add(
                                      ExecLogin(
                                          username: _usernameController.text,
                                          password: _passwordController.text,
                                          captcha: _captchaController.text,
                                          enableSSL: configureState.enableSSL,
                                          cookie: cookieState.cookie,
                                          lockSessionIP:
                                              configureState.lockSessionIP))
                                  : null,
                              child: Text('Link Start!'),
                            ),
                          ),
                          state is LoginFailure
                              ? Text(
                                  state.error,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox.shrink()
                        ],
                      ))));
}

class _Configuration extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ConfigureBloc, ConfigureState>(
          builder: (context, state) => Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Text('Lock Session IP'),
                    Checkbox(
                        value: state.lockSessionIP,
                        onChanged: (_) =>
                            BlocProvider.of<ConfigureBloc>(context).add(
                                ConfigureToggle(
                                    configureT: ConfigureT.lockSessionIP)))
                  ]),
                  Row(
                    children: <Widget>[
                      Text('Enable SSL'),
                      Checkbox(
                          value: state.enableSSL,
                          onChanged: (_) =>
                              BlocProvider.of<ConfigureBloc>(context).add(
                                  ConfigureToggle(
                                      configureT: ConfigureT.enableSSL)))
                    ],
                  ),
                ],
              ));
}
