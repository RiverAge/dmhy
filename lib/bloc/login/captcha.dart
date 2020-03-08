part of 'package:dmhy/bloc/login/login.dart';


class CaptchaBloc extends Bloc<CaptchaEvent, CaptchaState> {
  CaptchaBloc();

  @override
  CaptchaState get initialState => CaptchaInitial();

  @override
  Stream<CaptchaState> mapEventToState(CaptchaEvent event) async* {
    if (event is Refresh) {
      yield CaptchaPending();
      yield CaptchaRefreshed(seed: Random().nextDouble().toString());
    }
  }
}
