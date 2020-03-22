import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TorrentsEvent extends Equatable {
@override
  List<Object> get props => [];
}

class Fetch extends TorrentsEvent {
  final String token;
  final String query;

  Fetch({@required this.token,  this.query });
}