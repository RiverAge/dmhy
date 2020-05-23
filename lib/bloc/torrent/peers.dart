import 'package:dmhy/event/torrent/peers.dart';
import 'package:dmhy/repository/torrent/torrent_repository.dart';
import 'package:dmhy/state/torrent/peers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PeersBloc extends Bloc<PeersEvent, PeersState> {
  final _sl = GetIt.instance;

  @override
  PeersState get initialState => PeersInitial();

  @override
  Stream<PeersState> mapEventToState(PeersEvent event) async* {
    if (event is Fetch) {
      yield PeersPending();
      try {
        final peers = await _sl<TorrentRepository>()
            .fetchPeerByTorrent(token: event.token, tid: event.tid);
        yield PeersLoaded(peers: peers);
      } catch (e, stacktrace) {
        print(e);
        print(stacktrace);
        yield PeersFailed(error: e.toString());
      }
    }
  }
}
