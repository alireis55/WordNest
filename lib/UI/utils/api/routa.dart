class Routa {
  static const String _baseUrl = 'https://vocabulary.aktumen.com/api';
  static const String _login = '/login';
  static const String _register = '/register';
  static const String _random = '/random';

  static String loginUrl = _baseUrl + _login;
  static String registerUrl = _baseUrl + _register;
  static String randomeUrl = _baseUrl + _random;
}
