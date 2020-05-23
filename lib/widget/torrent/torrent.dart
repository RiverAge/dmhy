import 'package:dmhy/bloc/authenticate/authenticate.dart';
import 'package:dmhy/bloc/torrent/torrent.dart';
import 'package:dmhy/event/torrent/torrent.dart';
import 'package:dmhy/state/authenticate/authenticate.dart';
import 'package:dmhy/state/torrent/torrent.dart';
import 'package:dmhy/widget/torrent/peers.dart';
import 'package:dmhy/widget/torrent/torrent_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmhy/model/torrent/torrent.dart' as model;

class Torrent extends StatelessWidget {
  final String id;

  Torrent({@required this.id}) : assert(id != null);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) => state is AuthenticationAuthenticated
              ? BlocProvider(
                  create: (context) => TorrentBloc()
                    ..add(Fetch(token: state.token, id: this.id)),
                  child: _Torrent(),
                )
              : null);
}

class _Torrent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<TorrentBloc, TorrentState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(state is TorrentLoaded ? state.torrent.title : ''),
          ),
          body: state is TorrentLoaded
              ? ListView(
                  children: <Widget>[
                    state.torrent.cover != null
                        ? Image.network(state.torrent.cover)
                        : SizedBox.shrink(),
                    ListTile(title: Text(state.torrent.title)),
                    state.torrent.subtitle != null
                        ? ListTile(title: Text(state.torrent.subtitle))
                        : SizedBox.shrink(),
                    ListTile(title: Text(state.torrent.category)),
                    ListTile(title: Text(state.torrent.filesCount)),
                    ListTile(title: Text(state.torrent.fileHash)),
                    ListTile(title: Text(state.torrent.size)),
                    ListTile(title: Text(state.torrent.pv)),
                    ListTile(title: Text(state.torrent.uv)),
                    ListTile(title: Text(state.torrent.completions)),
                    ListTile(title: Text(state.torrent.lastActivity)),
                    ListTile(
                        title: Text(
                            '${state.torrent.seeders} | ${state.torrent.leechers}')),
                    ListTile(
                        title: Text('描述'),
                        onTap: () => _onReferenceTap(context, state.torrent)),
                    ListTile(
                      title: Text('做种列表'),
                      onTap: () => onPeersTap(context, state.torrent),
                    )
                  ],
                )
              : null,
        ),
      );

  _onReferenceTap(BuildContext context, model.Torrent torrent) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TorrentDescription(torrent: torrent)));
  }

  onPeersTap(BuildContext context, model.Torrent torrent) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Peers(tid: torrent.id)));
  }
}
