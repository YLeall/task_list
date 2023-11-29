const String baseUrl = 'http://10.0.2.2:5000';
// const String baseUrl = 'http://127.0.0.1:5000/';

abstract class EndPoints {
  static const String signIn = '$baseUrl/login';
  static const String signUp = '$baseUrl/users';
  static const String validateToken = '$baseUrl/validate-token';
  static const String getTasks = '$baseUrl/tasks';
}
