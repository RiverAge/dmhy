part of 'package:dmhy/bloc/login/login.dart';


class ConfigureBloc extends Bloc<ConfigureEvent, ConfigureState> {
  @override
  ConfigureState get initialState =>
      ConfigureState(lockSessionIP: false, enableSSL: false);

  @override
  Stream<ConfigureState> mapEventToState(ConfigureEvent event) async* {
    if (event is ConfigureToggle) {
      switch (event.configureT) {
        case ConfigureT.lockSessionIP:
          yield ConfigureState(
              lockSessionIP: !state.lockSessionIP,
              enableSSL: state.enableSSL);
          break;
        case ConfigureT.enableSSL:
          yield ConfigureState(
              lockSessionIP: state.lockSessionIP,
              enableSSL: !state.enableSSL);
          break;
      }
    }
  }
}
