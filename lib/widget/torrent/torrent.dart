import 'package:dmhy/bloc/authenticate/authenticate.dart';
import 'package:dmhy/bloc/torrent/torrent.dart';
import 'package:dmhy/event/torrent/torrent.dart';
import 'package:dmhy/state/authenticate/authenticate.dart';
import 'package:dmhy/state/torrent/torrent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            title: Text('种子'),
          ),
          body: state is TorrentLoaded
              ? ListView(
                  children: <Widget>[],
                )
              : null,
        ),
      );
}
