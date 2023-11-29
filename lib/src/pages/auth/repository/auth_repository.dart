import 'package:task_list/src/models/user_model.dart';
import 'package:task_list/src/service/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  //http://10.0.2.2:5000/users

  Future<({UserModel? user, String? error})> signUp({
    required String userName,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: "https://tasklist-api-vczi.onrender.com/users",
      method: HttpMethods.post,
      body: {
        'user_name': userName,
        'password': password,
      },
    );

    if (result.isNotEmpty) {
      final UserModel user = await Future.value(
        UserModel.fromMap(result,),
      );

      return (
        user: user,
        error: null,
      );
    }

    else {
      return (
        user: null,
        error: 'Erro ao cadastrar',
      );
    }

    //return handleUserOrError(result);

    //
  }

  Future<({String? accessToken, String? error})> signIn({
    required String userName,
    required String password,
  }) async {

    

    final result = await _httpManager.restRequest(
      url: "https://tasklist-api-vczi.onrender.com/login",
      method: HttpMethods.post,
      body: {
        'user_name': userName,
        'password': password,
      },
    );
    print(result);

    if (result.containsKey("access_token")) {

      final String accessToken = await Future.value(result["access_token"]);
     
      print("logou");
      print(accessToken);

      return (
        accessToken: accessToken,
        error: null,
      );
    } else {
      return (
        accessToken: null,
        error: 'Credenciais inválidas',
      );
    }

    //return handleUserOrError(result);

    //
  }
  //
}
