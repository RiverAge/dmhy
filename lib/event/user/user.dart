import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends UserEvent {
  final token;
  final uid;

  Fetch({@required this.token, @required this.uid})
      : assert(token != null),
        assert(uid != null);
}
