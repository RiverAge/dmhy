import 'package:dmhy/model/torrent/peer.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PeersState extends Equatable {
  @override
  List<Object> get props => [];
}

class PeersInitial extends PeersState {}

class PeersPending extends PeersState {}

class PeersLoaded extends PeersState {
  final List<Peer> peers;

  PeersLoaded({@required this.peers});
}

class PeersFailed extends PeersState {
  final String error;
  PeersFailed({@required this.error}) : assert(error != null);
}
