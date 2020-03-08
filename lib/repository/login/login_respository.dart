import 'package:meta/meta.dart';
import 'package:dmhy/api/login.dart' as loginAPI;

class LoginRepository {
  // final _httpClient = GetIt.instance<http.Client>();

  LoginRepository();

  Future<List<String>> authenticate(
      {@required String username,
      @required String password,
      @required String captcha,
      @required String cookie,
      bool lockSessionIP,
      bool enableSSL}) async {
    final token = await loginAPI.login(
        username: username,
        password: password,
        captcha: captcha,
        cookie: cookie,
        lockSessionIP: lockSessionIP,
        enableSSL: enableSSL);
    final uid = await loginAPI.getUid(token);

    return [token, uid];

  }

  Future<String> fetchCookie() {
    return loginAPI.fetchCookie();
  }
}
