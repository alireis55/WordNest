class Routa {
  static const String _baseUrl = 'https://worknest.up.railway.app/api';
  static const String _login = '/login';
  static const String _register = '/register';
  static const String _random = '/random-word';

  static String loginUrl = _baseUrl + _login;
  static String registerUrl = _baseUrl + _register;
  static String randomeUrl = _baseUrl + _random;
}
