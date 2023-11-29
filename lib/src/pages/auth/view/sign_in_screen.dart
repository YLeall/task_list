import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_list/src/pages/auth/components/auth_button.dart';
import 'package:task_list/src/pages/auth/components/auth_text_field.dart';
import 'package:task_list/src/pages/auth/controller/auth_controller.dart';
import 'package:task_list/src/pages_routes/app_pages.dart';
import 'package:task_list/src/service/validators.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    size: 80,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AuthTextField(
                    hintText: "Nome de usuário",
                    obscureText: false,
                    controller: userNameController,
                    validator: nameValidator,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthTextField(
                    hintText: "Senha",
                    obscureText: true,
                    controller: passwordController,
                    validator: passwordValidator,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Esqueceu a senha?',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Obx(
                    () => AuthButton(
                      text: 'Sign In',
                      onTap: authController.isLoading.value
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              // String userName = userNameController.text;
                              // String password = passwordController.text;
            
                              // authController.signIn(
                              //   userName: userName,
                              //   password: password,
                              // );
                              if (_formKey.currentState!.validate()) {
                                String userName = userNameController.text;
                                String password = passwordController.text;

                                authController.signIn(
                                  userName: userName,
                                  password: password,
                                );

                                print('Todos os campos estao validos');
                              } else {
                                print('nao');
                              }
                              //
                            },
                      child: authController.isLoading.value
                          ? const CircularProgressIndicator()
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não tem uma conta?',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(PagesRoutes.signUpRoute);
                        },
                        child: const Text(
                          ' Crie sua conta aqui',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
