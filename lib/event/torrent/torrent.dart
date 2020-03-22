import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TorrentEvent extends Equatable {
@override
  List<Object> get props => [];
}

class Fetch extends TorrentEvent {
  final String token;
  final String id;

  Fetch({@required this.token, @required this.id });
}