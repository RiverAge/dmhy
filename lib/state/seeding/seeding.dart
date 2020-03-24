import 'package:dmhy/model/torrent/torrent.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SeedingState extends Equatable {
 @override
  List<Object> get props => [];
 
}

class SeedingIntial extends SeedingState { }

class SeedingPending extends SeedingState { }

class SeedingLoaded extends SeedingState {
  final List<Torrent> torrents;

  SeedingLoaded({@required this.torrents});
}

class SeedingFailed extends SeedingState {
  final String error;
  @override
  List<Object> get props => [];

  SeedingFailed({@required this.error}) : assert(error != null); 
}