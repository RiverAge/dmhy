import 'package:dmhy/model/user/torrent.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TorrentsState extends Equatable {
  @override
  List<Object> get props => [];
}

class TorrentsInitial extends TorrentsState {}

class TorrentsPending extends TorrentsState {}

class TorrentsLoaded extends TorrentsState {
  final List<Torrent> torrents;

  TorrentsLoaded({@required this.torrents});
}

class TorrentsFailed extends TorrentsState {
  final String error;
  TorrentsFailed({@required this.error}) : assert(error != null);
}
