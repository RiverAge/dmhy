part of 'package:dmhy/event/login/login.dart';

abstract class CaptchaEvent extends Equatable {}

class Refresh extends CaptchaEvent {
  @override
  List<Object> get props => [];

  Refresh();
}
