import 'dart:convert';

import 'package:auto_ecole_app/models/user.dart';
import 'package:auto_ecole_app/views/home.dart';
import 'package:auto_ecole_app/views/home/homev2.dart';
import 'package:auto_ecole_app/views/home/navbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:auto_ecole_app/constants/contante.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final id = ''.obs;
  final nom = ''.obs;
  final prenom = ''.obs;
  final logine = ''.obs; // corrected variable name
  final emaile = ''.obs; // corrected variable name
  final passworde = ''.obs; // corrected variable name
  final imageUrl = ''.obs; // corrected variable name
  final role = ''.obs; // corrected variable name
  final typeid = 0.obs; // corrected variable name

  final box = GetStorage();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${url}users/login'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        var userData = responseData['user'];
        var id = userData['id'];
        var nom = userData['nom'];
        var prenom = userData['prenom'];
        var login = userData['login'];
        var userEmail = userData['email'];
        var imageUrl = userData['image_url'];
        var token = responseData['token'];
        role.value = json.decode(response.body)['role'];
        typeid.value = json.decode(response.body)['typeid'];

        print('User ID: $id');
        print('User Nom: $nom');
        print('User Prenom: $prenom');
        print('User Login: $login');
        print('User Email: $userEmail');
        print('User Image URL: $imageUrl');
        print('Token: $token');
        print(role.value);
        print(typeid.value);

        User connectedUser = User(
            id: id,
            nom: nom,
            prenom: prenom,
            login: login,
            password: password,
            email: emaile.value,
            image_url: imageUrl,
            token: token,
            type: role.value,
            typeid: typeid.value);

        /*  print("connectedUser" + connectedUser.toString()); */

        box.write('connectedUser', connectedUser);

        Get.offAll(() => const Navbar());
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;

      print(e.toString());
    }
  }
}
