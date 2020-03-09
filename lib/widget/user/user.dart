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
                  children: <Widget>[Text('邀请'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('邀请人'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('加入日期'), Text('加入日期')],
                ),
                Row(
                  children: <Widget>[Text('最近动向'), Text('最近动向')],
                ),
                Row(
                  children: <Widget>[Text('IP地址'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('分享率'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('上传量'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('下载量'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('实际上传'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('实际下载'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('做种/下载时间比率'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('做种时间'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text(' 下载时间'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('性别'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('网络带宽	'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('等级	'), Text('没有邀请资格')],
                ),
                Row(
                  children: <Widget>[Text('UCoin'), Text('没有邀请资格')],
                ),
              ],
            )
          : SizedBox.shrink());
}
