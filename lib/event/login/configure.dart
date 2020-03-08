part of 'package:dmhy/event/login/login.dart';

abstract class ConfigureEvent extends Equatable {}

enum ConfigureT { lockSessionIP, enableSSL }

class ConfigureToggle extends ConfigureEvent {
  final ConfigureT configureT;
  ConfigureToggle({@required this.configureT}) : assert(configureT != null);

  @override
  List<Object> get props => [];
}
