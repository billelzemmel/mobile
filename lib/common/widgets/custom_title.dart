
import 'package:flutter/material.dart';
import 'package:auto_ecole_app/constants/colors.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    Key? key,
    required this.title,
    this.route = '/404',
    this.extend = true,
    this.fontSize = 20.0,
    this.arg, 
    this.titreLien = "",
  }) : super(key: key);

  final String title;
  final String route;
  final bool extend;
  final double fontSize;
  final arg;
  final String titreLien;
  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: secondary,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: () {

          },
          child: Text(
            titreLien,
            style: const TextStyle(
                color: primary, fontSize: 15.0, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
