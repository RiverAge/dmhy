part of 'package:dmhy/state/login/login.dart';

class ConfigureState extends Equatable {
  final bool lockSessionIP;
  final bool enableSSL;

  ConfigureState(
      {
      @required this.lockSessionIP,
      @required this.enableSSL});

  @override
  List<Object> get props => [lockSessionIP, enableSSL];
}
