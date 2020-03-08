part of 'package:dmhy/state/login/login.dart';

abstract class CaptchaState extends Equatable {
  @override
  List<Object> get props => [];
}

class CaptchaInitial extends CaptchaState {}

class CaptchaPending extends CaptchaState {}

class CaptchaRefreshed extends CaptchaState {
  String get uri => 'https://u2.dmhy.org/captcha.php?sid=$_seed';
  final String _seed;
  CaptchaRefreshed({@required String seed}) : this._seed = seed;

   List<Object> get props => [_seed, uri];
}
