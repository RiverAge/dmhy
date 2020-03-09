import 'package:dmhy/model/user/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserPending extends UserState {}

class UserLoaded extends UserState {
  final User user;
  UserLoaded({@required this.user}) : assert(user != null);
}

class UserLoadFailed extends UserState {
  final String error;
  UserLoadFailed({@required this.error}) : assert(error != null);
}
