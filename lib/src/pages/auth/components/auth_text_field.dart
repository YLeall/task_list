import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
   final String? Function(String?)? validator;
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller, this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
