class CustomException implements Exception {
  final int code;

  CustomException(this.code);

  @override
  String toString() {
    return _getMessageForCode(code);
  }

  static String _getMessageForCode(int code) {
    switch (code) {
      case 400:
        return 'All fields are required';
      case 409:
        return 'This user already defined';
      case 200:
        return 'Successfully';
      case 401:
        return 'Invalid Credential';
      case 500:
        return 'Server Error';
      default:
        return 'Undefined Error';
    }
  }
}
