import 'package:dmhy/event/torrent/torrents.dart';
import 'package:dmhy/repository/torrent/torrent_repository.dart';
import 'package:dmhy/state/torrent/torrents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TorrentsBloc extends Bloc<TorrentsEvent, TorrentsState> {
  final _sl = GetIt.instance;

  @override
  TorrentsState get initialState => TorrentsInitial();

  @override
  Stream<TorrentsState> mapEventToState(TorrentsEvent event) async* {
    if (event is Fetch) {
      yield TorrentsPending();
      try {
        final torrents = await _sl<TorrentRepository>().search(token: event.token, query:event.query);
        yield TorrentsLoaded(torrents: torrents);
      } catch (e) {
        yield TorrentsFailed(error: e.toString());
      }
    }
  }
}
