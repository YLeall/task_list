import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Widget? child;
  const AuthButton({super.key, required this.text, this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: child ?? Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
