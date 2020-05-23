import 'package:dmhy/model/torrent/peer.dart';
import 'package:dmhy/model/torrent/torrent.dart';
import 'package:meta/meta.dart';
import 'package:dmhy/api/torrent.dart' as TorrentAPI;

class TorrentRepository {
  TorrentRepository();

  Future<Torrent> getTorrentInfo({@required token, @required tid}) {
   return TorrentAPI.fetchTorrent(cookie: token, tid: tid) ;
  }

  Future<List<Torrent>> search({@required token, query}) async {
    return TorrentAPI.queryTorrent(cookie: token, query: query) ;
  }

   Future<List<Peer>> fetchPeerByTorrent({@required token, tid}) async {
    return TorrentAPI.fetchPeerByTorrent(cookie: token, tid: tid) ;

  }
}