// ignore_for_file: public_member_api_docs, sort_constructors_first



class UserModel {
  int? id;
  String? userName;
  String? password;
  String? token;

  UserModel({
    this.id,
    this.userName,
    this.password,
    this.token,
  });

  factory UserModel.fromMap(Map<dynamic, dynamic> json) {
    return UserModel(
      userName: json['user_name'],
      password: json['password'],
      id: json['id'],
      token: json['refresh_token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_name': userName,
      'password': password,
      'token': token,
    };
  }


  @override
  String toString() {
    return 'UserModel(id: $id, userName: $userName, password: $password, token: $token)';
  }
}
