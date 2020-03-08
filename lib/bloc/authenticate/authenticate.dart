import 'package:dmhy/event/authenticate/authenticate.dart';
import 'package:dmhy/state/authenticate/authenticate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  @override
  AuthenticateState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticateState> mapEventToState(AuthenticateEvent event) async* {
    if (event is LoggedIn) {
      yield AuthenticationAuthenticated(token: event.token, uid: event.uid);
    }
    if (event is Loggout) {
      yield AuthenticationUnauthenticated();
    }
  }
}
