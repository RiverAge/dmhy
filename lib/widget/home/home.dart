import 'package:dmhy/bloc/authenticate/authenticate.dart';
import 'package:dmhy/state/authenticate/authenticate.dart';
import 'package:dmhy/widget/torrent/torrent.dart';
import 'package:dmhy/widget/user/bt_client.dart';
import 'package:dmhy/widget/user/user.dart';
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
                    Text('uid -> ${state.uid}'),
                    RaisedButton(
                      child: Text('BT 客户端'),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BTClient())),
                    ),
                    RaisedButton(
                        child: Text('用户信息'),
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => User()))),
                    RaisedButton(
                        child: Text('做种信息'),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Torrent()))),
                  ],
                )
              : SizedBox.shrink());
}
