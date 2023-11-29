import 'package:flutter/material.dart';

class ButtonTile extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const ButtonTile({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 60,
        padding: const EdgeInsets.only(top: 20, left: 14,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF4e5ae8),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
