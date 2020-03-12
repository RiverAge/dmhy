import 'package:dmhy/bloc/authenticate/authenticate.dart';
import 'package:dmhy/bloc/user/user.dart';
import 'package:dmhy/event/user/user.dart';
import 'package:dmhy/state/authenticate/authenticate.dart';
import 'package:dmhy/state/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) => state is AuthenticationAuthenticated
              ? BlocProvider(
                  create: (context) => UserBloc()
                    ..add(Fetch(token: state.token, uid: state.uid)),
                  child: _User(),
                )
              : null);
}

class _User extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => state is UserLoaded
          ? Scaffold(
              appBar: AppBar(
                title: Text(state.user.userName),
              ),
              body: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[Text('邀请'), Text(state.user.invitaion)],
                  ),
                  Row(
                    children: <Widget>[Text('邀请人'), Text(state.user.inviter)],
                  ),
                  Row(
                    children: <Widget>[Text('加入日期'), Text(state.user.joinDate)],
                  ),
                  Row(
                    children: <Widget>[
                      Text('最近动向'),
                      Text(state.user.recentTrends)
                    ],
                  ),
                  Row(
                    children: <Widget>[Text('分享率'), Text(state.user.ratio)],
                  ),
                  Row(
                    children: <Widget>[Text('上传量'), Text(state.user.upload)],
                  ),
                  Row(
                    children: <Widget>[Text('下载量'), Text(state.user.download)],
                  ),
                  Row(
                    children: <Widget>[
                      Text('实际上传'),
                      Text(state.user.actualUpload)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('实际下载'),
                      Text(state.user.actualDownload)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('做种/下载时间比率'),
                      Text(state.user.seedingDownloadRatio)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('做种时间'),
                      Text(state.user.seedingTime)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('下载时间'),
                      Text(state.user.downloadTime)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('上传速度'),
                      Text(state.user.uploadSpeed)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('下载速度'),
                      Text(state.user.downloadSpeed)
                    ],
                  ),
                  Row(
                    children: <Widget>[Text('运营商'), Text(state.user.isp)],
                  ),
                  Row(
                    children: <Widget>[Text('性别'), Text(state.user.gender)],
                  ),
                  Row(
                    children: <Widget>[
                      Text('头像'),
                      Image.network('https:' + state.user.avatar)
                    ],
                  ),
                  Row(
                    children: <Widget>[Text('等级'), Text(state.user.level)],
                  ),
                  Row(
                    children: <Widget>[Text('UCoin'), Text(state.user.ucoin)],
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
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('用户信息'),
              ),
            ));
}
