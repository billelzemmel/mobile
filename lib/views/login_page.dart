import 'package:auto_ecole_app/controllers/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/input_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login'; 
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Login Page',
          style: GoogleFonts.poppins(fontSize: 30), // Wrap with GoogleFonts
        ),
        const SizedBox(
          height: 30,
        ),
        inputWidget(
          hintText: 'Email',
          controller: _emailController,
          obscureText: false,
        ),
        const SizedBox(
          height: 20,
        ),
        inputWidget(
          hintText: 'Password',
          controller: _passwordController,
          obscureText: true,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF31A0FE),
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20)),
            onPressed: () async {
              await _authenticationController.login(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim());
            },
            child: Obx(() {
              return _authenticationController.isLoading.value
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text('Login',
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.white));
            }))
      ],
    )));
  }
}
