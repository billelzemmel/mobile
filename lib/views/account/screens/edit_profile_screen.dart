import 'dart:io';

import 'package:auto_ecole_app/common/widgets/custom_textfield_second.dart';
import 'package:auto_ecole_app/models/user.dart';
import 'package:auto_ecole_app/models/user_provider.dart';
import 'package:auto_ecole_app/views/account/services/account_service.dart';
import 'package:auto_ecole_app/views/home/homev2.dart';
import 'package:auto_ecole_app/views/home/navbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:auto_ecole_app/common/widgets/custom_button_box.dart';
import 'package:auto_ecole_app/constants/colors.dart';
import 'package:auto_ecole_app/constants/padding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/editProfil';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _editUserProfileFormKey = GlobalKey<FormState>();

  bool isCharging = false;

  PlatformFile? image;
  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result == null) return;

    setState(() {
      image = result.files.first;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    prenomController.dispose();
    loginController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  // void selectImages() async {
  //   var res = await pickImages();
  //   setState(() {
  //     images = res;
  //   });
  // }

  void editUserProfile() {
    if (_editUserProfileFormKey.currentState!.validate()) {
      setState(() {
        isCharging = true;
      });
      AccountService.editUserProfile(
        context,
        nameController.text,
        prenomController.text,
        loginController.text,
        passwordController.text,
        emailController.text,
        image,
      ).then((_) {
        setState(() {
          isCharging = false;
        });
        Get.back();
      }).catchError((error) {
        setState(() {
          isCharging = false;
        });
        // Handle errors, e.g., show an error message
        Get.snackbar('Error', 'Failed to update profile',
            backgroundColor: Colors.red);
      });
    }
  }

  var items = ["M", "F"];

  String dropdownvalue = "M";

  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();

    User? user = box.read('connectedUser');
    if (isCharging == false) {
      nameController.text = user!.nom.toUpperCase().trim();
      prenomController.text = user.prenom.toUpperCase().trim();
      loginController.text = user.login.toUpperCase().trim();
      passwordController.text = user.password.toUpperCase();
      emailController.text = user.email.trim();
      ;
    } else {
      nameController.text = nameController.text.trim();
      prenomController.text = prenomController.text.trim();
      loginController.text = loginController.text.trim();
      passwordController.text = passwordController.text.trim();
      emailController.text = emailController.text.trim();
    }
    // isCharging == false
    //     ? nameController.text = user.nom.toUpperCase()
    //     : nameController.text = nameController.text;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.offAll(() => Navbar());
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(appPadding),
            child: Form(
              key: _editUserProfileFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: spacer,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          image != null
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  child: Image.file(
                                    File(image!.path!),
                                    width: 100,
                                    height: 100,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  child: Hero(
                                    tag: 'profile-photo',
                                    child: Image.network(
                                      user!.image_url,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                          Positioned(
                            top: 50,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: background,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(Icons.camera_alt_rounded)),
                            ),
                          )
                        ],
                      ),

                      Text(
                        user!.nom.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // CustomTitle(
                      //   title: '${user.nom.toUpperCase()}',
                      //   extend: false,
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: spacer - 25,
                  ),
                  CustomTextFieldSecond(
                    prefixIcon: "user_icon.svg",
                    labelText: "Nom",
                    controller: nameController,
                    iconColor: primary,
                  ),
                  const SizedBox(
                    height: spacer - 25,
                  ),
                  CustomTextFieldSecond(
                    prefixIcon: "user_icon.svg",
                    labelText: "Prenom",
                    controller: prenomController,
                    iconColor: primary,
                  ),
                  const SizedBox(
                    height: spacer - 25,
                  ),
                  CustomTextFieldSecond(
                    prefixIcon: "user_icon.svg",
                    labelText: "Login",
                    controller: loginController,
                    iconColor: primary,
                  ),
                  const SizedBox(
                    height: spacer - 25,
                  ),
                  CustomTextFieldSecond(
                    prefixIcon: "email_icon.svg",
                    labelText: "Email",
                    controller: emailController,
                    iconColor: primary,
                  ),
                  const SizedBox(
                    height: spacer - 25,
                  ),
                  CustomTextFieldSecond(
                    prefixIcon: "key_icon.svg",
                    labelText: "Password",
                    controller: passwordController,
                    iconColor: primary,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: spacer,
                  ),
                  GestureDetector(
                      onTap: () {

print(' nameController.text,${ nameController.text}');

                        // if (_editUserProfileFormKey.currentState!.validate()) {
                        //   setState(() {
                        //     isCharging = true;
                        //   });
                          editUserProfile();
                      //  }
                      },
                      child: Column(
                        children: [
                          const CustomButtonBox(title: "Modifier"),
                          isCharging == true
                              ? const CircularProgressIndicator(
                                  color: primary,
                                )
                              : const Text("")
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
