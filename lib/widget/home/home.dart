import 'package:dmhy/bloc/authenticate/authenticate.dart';
import 'package:dmhy/state/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) => state is AuthenticationAuthenticated
              ? Column(
                  children: <Widget>[
                    Text('token -> ${state.token}'),
                    Text('uid -> ${state.uid}')
                  ],
                )
              : SizedBox.shrink());
}
