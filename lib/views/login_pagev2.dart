import 'dart:async';

import 'package:auto_ecole_app/common/widgets/login_button.dart';
import 'package:auto_ecole_app/controllers/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_ecole_app/common/animations/opacity_tween.dart';
import 'package:auto_ecole_app/common/animations/slide_down_tween.dart';
import 'package:auto_ecole_app/common/widgets/custom_button_box.dart';
import 'package:auto_ecole_app/common/widgets/custom_heading.dart';
import 'package:auto_ecole_app/common/widgets/custom_textfield.dart';

import 'package:auto_ecole_app/constants/colors.dart';
import 'package:auto_ecole_app/constants/padding.dart';
import 'package:auto_ecole_app/constants/utils.dart';
import 'package:get/get.dart';

enum Auth {
  login,
}

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  bool isCharging = false;

  final _signInFormKey = GlobalKey<FormState>();

  void signInUser() {
    // Your sign-in logic goes here
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(appPadding),
              child: Form(
                key: _signInFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideDownTween(
                      offset: 40,
                      delay: 1.0,
                      child: OpacityTween(
                        begin: 0,
                        child: Center(
                          child: SvgPicture.asset(
                            "${assetImg}login_image.svg",
                            width: 250,
                            height: 250,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: spacer - 40,
                    ),
                    const SlideDownTween(
                      delay: 1.4,
                      offset: 40,
                      child: OpacityTween(
                        begin: 0.2,
                        child: CustomHeading(
                          title: "Connectez-vous",
                          subTitle: "Bienvenue à vous",
                          color: secondary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: spacer - 40,
                    ),
                    SlideDownTween(
                      offset: 50,
                      delay: 1.6,
                      child: OpacityTween(
                        begin: 0.4,
                        child: CustomTextField(
                          prefixIcon: "email_icon.svg",
                          labelText: "Adresse email",
                          controller: _emailController,
                          iconColor: primary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: spacer - 40,
                    ),
                    SlideDownTween(
                      offset: 50,
                      delay: 1.6,
                      child: OpacityTween(
                        begin: 0.4,
                        child: CustomTextField(
                          prefixIcon: "key_icon.svg",
                          labelText: "Mot de passe",
                          controller: _passwordController,
                          iconColor: primary,
                          isPassword: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: spacer,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_signInFormKey.currentState!.validate()) {
                          setState(() {
                            isCharging = true;
                          });
                          signInUser();
                        }
                      },
                      child: SlideDownTween(
                        offset: 40,
                        delay: 2.0,
                        child: OpacityTween(
                          begin: 0.5,
                          child: Column(
                            children: [
                              LoginButton(
                                  title: "Se connecter",
                                  onPressed: () async {
                                    await _authenticationController.login(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    );
                                  }),
                              isCharging == true
                                  ? const CircularProgressIndicator(
                                      color: primary,
                                    )
                                  : const Text("")
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: spacer - 30,
                    ),
                    SlideDownTween(
                      offset: 40,
                      delay: 2.0,
                      child: OpacityTween(
                        begin: 0.6,
                        child: Row(
                          children: [
                            Text(
                              "Vous n'avez pas de compte ?",
                              style: TextStyle(
                                color: secondary.withOpacity(0.5),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Perform any necessary state changes
                                });
                              },
                              child: const Text(
                                "Contacter nous",
                                style: TextStyle(color: primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: spacer - 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
