import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SeedingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends SeedingEvent {
  final String token;
  final String uid;

  Fetch({@required this.token, @required this.uid});
}
