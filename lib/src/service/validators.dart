import 'package:get/get.dart';

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite um nome';
  }

  if (name.length == 1) {
    return 'Digite um nome com pelo menos 3 caracteres';
  }

  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Digite sua senha';
  }

  if (password.length < 7) {
    return 'Digite uma senha com pelo menos 7 caracteres';
  }

  return null;
}
