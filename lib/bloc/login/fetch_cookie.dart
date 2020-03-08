part of 'package:dmhy/bloc/login/login.dart';

class FetchCookieBloc extends Bloc<FetchCookieEvent, FetchCookieState> {
  @override
  FetchCookieState get initialState => CookieInitial();

  final CaptchaBloc captchaBloc;

  FetchCookieBloc({@required this.captchaBloc}) : assert(captchaBloc != null);

  final _sl = GetIt.instance;

  @override
  Stream<FetchCookieState> mapEventToState(FetchCookieEvent event) async* {
    if (event is Fetch) {
      yield CookiePending();

      try {
        final cookie = await _sl<LoginRepository>().fetchCookie();
        yield CookieLoaded(cookie: cookie);
        captchaBloc.add(Refresh());
      } catch (e) {
        yield CookieFailed(error: e.toString());
      }
    }
  }
}
