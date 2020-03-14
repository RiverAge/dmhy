import 'package:dmhy/event/user/user.dart';
import 'package:dmhy/repository/user/user_repository.dart';
import 'package:dmhy/state/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _sl = GetIt.instance;

  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is Fetch) {
      yield UserPending();

      try {
        final user = await _sl<UserRepository>()
            .getDetail(token: event.token, uid: event.uid);
        yield UserLoaded(user: user);
      } catch (e) {
        yield UserLoadFailed(error: e.toString());
      }
    }
  }
}
