import 'package:flutter/material.dart';

class inputWidget extends StatelessWidget {
  const inputWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
  });
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20)),
      ),
    );
  }
}
