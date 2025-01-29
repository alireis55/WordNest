class LoginModel {
  late String email;
  late String password;

  LoginModel({required this.email, required this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

class RegisterModel {
  final String username;
  final String email;
  final String password;

  RegisterModel(
      {required this.username, required this.email, required this.password});

  RegisterModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = username;
    data['password'] = email;
    data['name'] = password;
    return data;
  }
}
