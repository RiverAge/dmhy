import 'package:dmhy/event/torrent/files.dart';
import 'package:dmhy/repository/torrent/torrent_repository.dart';
import 'package:dmhy/state/torrent/files.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FilesBloc extends Bloc<FilesEvent, FilesState> {
  final _sl = GetIt.instance;

  @override
  FilesState get initialState => FilesInitial();

  @override
  Stream<FilesState> mapEventToState(FilesEvent event) async* {
    if (event is Fetch) {
      yield FilesPending();
      try {
        final files = await _sl<TorrentRepository>()
            .fetchFilesByTorrent(token: event.token, tid: event.tid);
        yield FilesLoaded(files: files);
      } catch (e) {
        yield FilesFailed(error: e.toString());
      }
    }
  }
}
