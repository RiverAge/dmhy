part of 'package:dmhy/state/login/login.dart';

abstract class FetchCookieState extends Equatable {}

class CookieInitial extends FetchCookieState {
  @override
  List<Object> get props => [];
}

class CookiePending extends FetchCookieState {
  @override
  List<Object> get props => [];
}

class CookieLoaded extends FetchCookieState {
  final String cookie;
  @override
  List<Object> get props => [];

  CookieLoaded({@required this.cookie}) : assert(cookie != null);
}

class CookieFailed extends FetchCookieState {
  final String error;
  @override
  List<Object> get props => [];

  CookieFailed({@required this.error}) : assert(error != null);
}
