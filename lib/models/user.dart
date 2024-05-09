import 'dart:convert';
import 'dart:ffi';

class User {
  final int id;
  final String nom;
  final String prenom;
  final String login;
  final String password;
  final String email;
  final String type;
  final String image_url;
  final String token;
  final int typeid;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.login,
    required this.password,
    required this.email,
    required this.type,
    required this.image_url,
    required this.token,
    required this.typeid,

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'login': login,
      'password': password,
      'email': email,
      'type': type,
      'image_url': image_url,
      'token': token,
      'typeid': typeid,

    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      login: map['login'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      type: map['type'] ?? '',
      image_url: map['image_url'] ?? '',
      token: map['token'] ?? '',
      typeid: map['typeid'] ?? '',

    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
