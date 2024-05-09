import 'dart:convert';
import 'dart:ffi';

class Students {
  final int id;
  final String nom;
  final String prenom;
  final String image;

  Students({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.image,

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'image': image,

    };
  }

  factory Students.fromMap(Map<String, dynamic> map) {
    return Students(
      id: map['id'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      image: map['image'] ?? '',

    );
  }

  String toJson() => json.encode(toMap());

  factory Students.fromJson(String source) => Students.fromMap(json.decode(source));
}
