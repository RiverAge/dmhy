import 'package:dmhy/event/torrent/torrent.dart';
import 'package:dmhy/repository/torrent/torrent_repository.dart';
import 'package:dmhy/state/torrent/torrent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TorrentBloc extends Bloc<TorrentEvent, TorrentState> {
  final _sl = GetIt.instance;

  @override
  TorrentState get initialState => TorrentInitial();

  @override
  Stream<TorrentState> mapEventToState(TorrentEvent event) async* {
    if (event is Fetch) {
      yield TorrentPending();
      try {
        final torrent = await _sl<TorrentRepository>()
            .getTorrentInfo(token: event.token, tid: event.id);
        yield TorrentLoaded(torrent: torrent);
      } catch (e) {
        yield TorrentFailed(error: e.toString());
      }
    }
  }
}
