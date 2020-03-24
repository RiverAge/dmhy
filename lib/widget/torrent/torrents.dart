import 'package:dmhy/bloc/authenticate/authenticate.dart';
import 'package:dmhy/bloc/torrent/torrents.dart';
import 'package:dmhy/event/torrent/torrents.dart';
import 'package:dmhy/state/authenticate/authenticate.dart';
import 'package:dmhy/model/torrent/torrent.dart' as model;
import 'package:dmhy/state/torrent/torrents.dart';
import 'package:dmhy/widget/torrent/torrent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Torrents extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) => state is AuthenticationAuthenticated
              ? BlocProvider(
                  create: (context) =>
                      TorrentsBloc()..add(Fetch(token: state.token, query: '')),
                  child: _Torrents(),
                )
              : null);
}

class _Torrents extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TorrentsBloc, TorrentsState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text('做种'),
          ),
          body: state is TorrentsLoaded
              ? ListView.builder(
                  itemBuilder: (_, i) => _ListTitle(torrent: state.torrents[i]),
                  itemCount: state.torrents.length,
                )
              : null,
        ),
      );
}

class _ListTitle extends StatelessWidget {
  final model.Torrent torrent;
  _ListTitle({@required this.torrent, Key key});
  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Torrent(
                      id: torrent.id,
                    ))),
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
        subtitle: Row(
          children: <Widget>[
            torrent.isHot ? Text('热门') : SizedBox.shrink(),
            Text(
              torrent.discountRemain,
            ),
          ],
        ),
        isThreeLine: true,
      );
}
