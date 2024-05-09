import 'package:auto_ecole_app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user =
      User(
          id: 0,
          nom: "",
          prenom: "",
         login: '', 
          password: "",
          email: "",
          token: '', 
          type: '',
          image_url :'',
          typeid:0
          );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
