import 'package:dmhy/bloc/authenticate/authenticate.dart';
import 'package:dmhy/bloc/seeding/seeding.dart';
import 'package:dmhy/event/seeding/seeding.dart';
import 'package:dmhy/model/user/torrent.dart' as model;
import 'package:dmhy/state/authenticate/authenticate.dart';
import 'package:dmhy/state/seeding/seeding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Seedings extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) => state is AuthenticationAuthenticated
              ? BlocProvider(
                  create: (context) => SeedingBloc()
                    ..add(Fetch(token: state.token, uid: state.uid)),
                  child: _Seedings(),
                )
              : null);
}

class _Seedings extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<SeedingBloc, SeedingState>(
      builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text('做种'),
            ),
            body: state is SeedingLoaded
                ? ListView.builder(
                    itemBuilder: (_, i) =>
                        _ListTitle(torrent: state.torrents[i]),
                    itemCount: state.torrents.length)
                : null,
          ));
}

class _ListTitle extends StatelessWidget {
  final model.Torrent torrent;
  _ListTitle({@required this.torrent, Key key});
  @override
  Widget build(BuildContext context) => ListTile(
        leading: Column(
          children: <Widget>[
            Text(torrent.category),
            Text(
              torrent.size,
            ),
            Column(
              children: <Widget>[
                Text(
                  torrent.discount,
                ),
                Text(
                  torrent.discountRemain,
                ),
              ],
            )
          ],
        ),
        title: Column(
          children: <Widget>[
            Text(
              torrent.title,
              style: TextStyle(fontSize: 13),
            ),
            Text(
              torrent.subtitle,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        subtitle: Text('${torrent.uploadSize} | ${torrent.downloadSize}'),
        trailing: Text(torrent.ratio),
        isThreeLine: true,
      );
}
