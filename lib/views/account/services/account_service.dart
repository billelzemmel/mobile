import 'dart:convert';
import 'dart:io';

import 'package:auto_ecole_app/constants/contante.dart';
import 'package:auto_ecole_app/models/user.dart';
import 'package:auto_ecole_app/models/user_provider.dart';
import 'package:auto_ecole_app/views/home/navbar.dart';
import 'package:auto_ecole_app/views/login_pagev2.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:auto_ecole_app/constants/error_handling.dart';
import 'package:auto_ecole_app/constants/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  // LOGOUT USER
  static void logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('x-auth-token');
    Get.offAll(() => AuthScreen());
  }

  static Future<void> editUserProfile(
      BuildContext context,
      String name,
      String prenom,
      String login,
      String password,
      String email,
      PlatformFile? image) async {
    GetStorage box = GetStorage();
    User? conuser = box.read('connectedUser');

    print("Submitting with:");
    print("id: ${conuser?.id}");

    print("Name: $name");
    print("Prenom: $prenom");
    print("Login: $login");
    print("Password: $password");
    print("Email: $email");
    print("Type: ${conuser?.type}");
    print("Image: ${image?.name}");

    Uri uri = Uri.parse('${url}users/${conuser?.id}');
    print(uri);
    var request = http.MultipartRequest('POST', uri)
      ..fields['nom'] = name.toString()
      ..fields['prenom'] = prenom
      ..fields['login'] = login
      ..fields['password'] = password
      ..fields['email'] = email
      ..fields['type'] = conuser?.type ?? 'moniteur';
    request.headers.addAll({
      'Accept': 'application/json',
      'Content-type': 'multipart/form-data',
    });
    print(request);

    if (image != null) {
      request.files.add(http.MultipartFile(
        'image',
        File(image.path!).readAsBytes().asStream(),
        File(image.path!).lengthSync(),
        filename: image.name,
      ));
    }
    print(request.files.toString());

    var response = await request.send();

    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print('User updated successfully');
      Get.snackbar('Success', 'User updated successfully',
          backgroundColor: Colors.green);
                  Get.offAll(() =>  AuthScreen());

    } else {
      print('Failed to update user: Status Code ${response.statusCode}');
      print('Response Body: $responseBody');
      Get.snackbar('Error', 'Failed to update user: $responseBody',
          backgroundColor: Colors.red);
    }
  }
}
