import 'package:dmhy/event/seeding/seeding.dart';
import 'package:dmhy/repository/user/user_repository.dart';
import 'package:dmhy/state/seeding/seeding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SeedingBloc extends Bloc<SeedingEvent, SeedingState> {
  final _sl = GetIt.instance;
  
  @override
  SeedingState get initialState => SeedingIntial();

  @override
  Stream<SeedingState> mapEventToState(SeedingEvent event) async *{
    if (event is Fetch) {
      yield SeedingPending();
      try {
        final torrents = await _sl<UserRepository>().getCurrentSeedings(token: event.token, uid: event.uid);
        yield SeedingLoaded(torrents: torrents);
      } catch(e) {
        yield SeedingFailed(error: e.toString());
      }
    }
  }

}