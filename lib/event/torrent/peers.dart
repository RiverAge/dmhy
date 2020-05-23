import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PeersEvent extends Equatable {
@override
  List<Object> get props => [];
}

class Fetch extends PeersEvent {
  final String token;
  final String tid;

  Fetch({@required this.token, @required this.tid });
}