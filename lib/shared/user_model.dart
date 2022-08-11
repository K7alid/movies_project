class UserModel {
  late String name;
  late String email;
  late String phone;
  late String password;
  late String uId;
  bool isEmailVerified = false;

  UserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
    required this.uId,
    required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
