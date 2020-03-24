import 'package:dmhy/model/torrent/torrent.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TorrentState extends Equatable {
  @override
  List<Object> get props => [];
}

class TorrentInitial extends TorrentState {}

class TorrentPending extends TorrentState {}

class TorrentLoaded extends TorrentState {
  final Torrent torrent;

  TorrentLoaded({@required this.torrent});
}

class TorrentFailed extends TorrentState {
  final String error;
  TorrentFailed({@required this.error}) : assert(error != null);
}
