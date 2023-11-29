import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_list/src/pages/auth/components/auth_button.dart';
import 'package:task_list/src/pages/auth/components/auth_text_field.dart';
import 'package:task_list/src/pages/auth/controller/auth_controller.dart';
import 'package:task_list/src/service/validators.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

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
                    'Sign Up',
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
                    height: 25,
                  ),
                  Obx(
                    () => AuthButton(
                      text: 'Sign Up',
                      onTap: authController.isLoading.value
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();

                              if (_formKey.currentState!.validate()) {
                                String userName = userNameController.text;
                                String password = passwordController.text;

                                authController.signUp(
                                  userName: userName,
                                  password: password,
                                );

                                print('Todos os campos estao validos');
                              } else {
                                print('nao');
                              }
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
                        'Tem uma conta?',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Text(
                          ' Entre aqui',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
