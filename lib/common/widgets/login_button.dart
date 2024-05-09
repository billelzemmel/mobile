import 'package:flutter/material.dart';
import 'package:auto_ecole_app/constants/colors.dart';

class LoginButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const LoginButton({
    required this.title,
    required this.onPressed,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 45.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primary.withOpacity(0.7), // Make sure primary color is defined
        borderRadius: BorderRadius.circular(17.5),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.5), // Make sure primary color is defined
            spreadRadius: 0.0,
            blurRadius: 6.0,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed, // Use widget.onPressed to access the onPressed callback
        child: Text(
          widget.title, // Use widget.title to access the title
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: textWhite, // Make sure textWhite color is defined
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.5),
          ),
        ),
      ),
    );
  }
}
