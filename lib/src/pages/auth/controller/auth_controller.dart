import 'package:get/get.dart';
import 'package:task_list/src/models/user_model.dart';
import 'package:task_list/src/pages/auth/repository/auth_repository.dart';
import 'package:task_list/src/pages_routes/app_pages.dart';
import 'package:task_list/src/service/utils_service.dart';

class AuthController extends GetxController {
  AuthRepository authRepository = AuthRepository();
  RxBool isLoading = false.obs;
  UserModel user = UserModel();
  UtilsService utilsServices = UtilsService();


  void signUp({
    required String userName,
    required String password,
  }) async {
    isLoading.value = true;

    final (:user, :error) = await authRepository.signUp(
      userName: userName,
      password: password,
    );

    isLoading.value = false;

    if (user != null) {
      this.user = user;
      Get.offAllNamed(PagesRoutes.signInRoute);
    } else {
      utilsServices.showToast(
        message: error!,
        isError: true,
      );
    }
    print(user);
    //
  }

  void signIn({
    required String userName,
    required String password,
  }) async{
    isLoading.value = true;

    final (:accessToken, :error) = await authRepository.signIn(
      userName: userName,
      password: password,
    );

    isLoading.value = false;

    if (accessToken!=null) {
      this.user.token = accessToken;
      Get.offAllNamed(PagesRoutes.homeRoute);
    } else {
      utilsServices.showToast(
        message: error!,
        isError: true,
      );
    }
    print(user);
  }
}



// void signUp2() async {
//   var url = 'http://10.0.2.2:5000/users';
//   // var url = 'http://192.168.56.1:5000/users';

//   final body = {
//     'user_name': 'teste3',
//     'password': 'oi',
//   };
//   String bodyf = jsonEncode(body);
//   Map<String, String> customheaders = {
//     "accept": "application/json",
//     "content-type": "application/json"
//   };

//   final response =
//       await http.post(Uri.parse(url), headers: customheaders, body: bodyf);
//   print(response.body);
// }


 // void signUp() async {
  //   var url = 'http://10.0.2.2:5000/users'; // Endereço da sua API local
  //   final body = {
  //     'user_name': 'mais um',
  //     'password': 'hhe',
  //   };

  //   try {
  //     final response = await Dio().post(url, data: body);
  //     print(response.data);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
