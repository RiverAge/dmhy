class WrongCaptchaException implements Exception {
  WrongCaptchaException();

  @override
  String toString() {
    return 'Wrong CAPTCHA answer';
  }
}
