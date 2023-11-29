import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_list/src/pages/auth/controller/auth_controller.dart';
import 'package:task_list/src/pages/auth/view/sign_in_screen.dart';
import 'package:task_list/src/pages/home/home_screen.dart';
import 'package:task_list/src/pages/task/controller/task_controller.dart';
import 'package:task_list/src/pages_routes/app_pages.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: PagesRoutes.signInRoute,
      getPages: AppPages.pages,
    );
  }
}
