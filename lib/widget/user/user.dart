import 'package:dmhy/bloc/authenticate/authenticate.dart';
import 'package:dmhy/bloc/user/user.dart';
import 'package:dmhy/event/user/user.dart';
import 'package:dmhy/state/authenticate/authenticate.dart';
import 'package:dmhy/state/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('RiverAge'),
      ),
      body: BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) => state is AuthenticationAuthenticated
              ? BlocProvider(
                  create: (context) => UserBloc()
                    ..add(Fetch(token: state.token, uid: state.uid)),
                  child: _User(),
                )
              : null));
}

class _User extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => state is UserLoaded
          ? Column(
              children: <Widget>[
               Row(
                children: <Widget>[
                 Text('邀请'),
                 Text(state.user.invitaion) 
                ],
               ),
               Row(
                children: <Widget>[
                 Text('邀请人'),
                 Text(state.user.inviter) 
                ],
               ),
               Row(
                children: <Widget>[
                 Text('加入日期'),
                 Text(state.user.joinDate) 
                ],
               ),
               Row(
                children: <Widget>[
                 Text('最近动向'),
                 Text(state.user.recentTrends) 
                ],
               ),
               Row(
                children: <Widget>[
                 Text('UCoin'),
                 Text(state.user.ucoin) 
                ],
               ),
               Row(
                children: <Widget>[
                 Text('收到好人卡'),
                 Text(state.user.friendZone) 
                ],
               ),
               Row(
                children: <Widget>[
                 Text('收到坏人卡'),
                 Text(state.user.badGuyZone) 
                ],
               ),
               Row(
                children: <Widget>[
                 Text('经验值'),
                 Text(state.user.experience) 
                ],
               ),
              ],
            )
          : SizedBox.shrink());
}
