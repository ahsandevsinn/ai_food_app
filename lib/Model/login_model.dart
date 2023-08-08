class LoginModel {
  String? info;
  String? password;

  LoginModel({this.info, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    info = json['info'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['info'] = info;
    data['password'] = password;
    return data;
  }
}

class LoginResponseModel {
  final String message;

  LoginResponseModel({required this.message});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(message: json['message']);
  }
}
