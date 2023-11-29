import 'package:get/get.dart';
import 'package:task_list/src/pages/home/bindings/task_binding.dart';
import 'package:task_list/src/pages/home/home_screen.dart';
import 'package:task_list/src/pages/task/add_task_screen.dart';

import '../pages/auth/view/sign_in_screen.dart';
import '../pages/auth/view/sign_up_screen.dart';

abstract class AppPages {

  static final pages = <GetPage>[

    // GetPage(
    //   name: PagesRoutes.splashRoute,
    //   page: () => const SplashScreen(),
    // ),

    GetPage(
      name: PagesRoutes.signInRoute,
      page: () => SignInScreen(),
    ),

    GetPage(
      name: PagesRoutes.signUpRoute,
      page: () => SignUpScreen(),
    ),

    GetPage(
      name: PagesRoutes.homeRoute,
      page: () => HomeScreen(),
      bindings: [
        TaskBinding(),
      ]
    ),

    GetPage(
      name: PagesRoutes.taskRoute, 
      page: () => AddTaskScreen(),
    ),

  ];

}


abstract class PagesRoutes {

  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String taskRoute = '/task';
  static const String homeRoute = '/';
  
}

