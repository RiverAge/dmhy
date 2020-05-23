// 正在做种
import 'package:dmhy/bloc/authenticate/authenticate.dart';
import 'package:dmhy/bloc/torrent/peers.dart';
import 'package:dmhy/event/torrent/peers.dart';
import 'package:dmhy/model/torrent/peer.dart';
import 'package:dmhy/state/authenticate/authenticate.dart';
import 'package:dmhy/state/torrent/peers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Peers extends StatelessWidget {
  final String tid;

  Peers({@required this.tid}) : assert(tid != null);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) => state is AuthenticationAuthenticated
              ? BlocProvider(
                  create: (context) =>
                      PeersBloc()..add(Fetch(token: state.token, tid: tid)),
                  child: _Peers(),
                )
              : null);
}

class _Peers extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<PeersBloc, PeersState>(
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text('同伴'),
            ),
            body: state is PeersLoaded
                ? ListView.builder(
                    itemBuilder: (context, index) =>
                        _PeerItem(peer: state.peers[index]),
                    itemCount: state.peers.length,
                  )
                : null),
      );
}

class _PeerItem extends StatelessWidget {
  final Peer peer;

  _PeerItem({@required this.peer, Key key});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Column(
          children: [
            Text(peer.userName),
            Text(peer.ratio),
          ],
        ),
        title: Column(children: [
          Text('${peer.uploadSize} | ${peer.averageUploadSpeed}'),
          Text('${peer.downloadSize} | ${peer.averageDownloadSpeed}'),
        ]),
        subtitle: Column(children: [
          Text('${peer.connectTime} | ${peer.idleTime}'),
          Text(peer.btClient)
        ]),
      );
}
