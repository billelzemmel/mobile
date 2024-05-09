import 'dart:convert';
import 'dart:ffi';

class Car {
  final int id;
  final String nom;
  final String matricule;
  final String type;
  final String image;
  final int disponible;
  final int moniteur_id;

  Car({
    required this.id,
    required this.nom,
    required this.matricule,
    required this.type,
    required this.disponible,
    required this.moniteur_id,
    required this.image,

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'matricule': matricule,
      'type': type,
      'image': image,
      'moniteur_id': moniteur_id,
      'disponible': disponible,

    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'] ?? '',
      nom: map['nom'] ?? '',
      matricule: map['matricule'] ?? '',
      type: map['type'] ?? '',
      disponible: map['disponible'] ?? '',
      moniteur_id: map['moniteur_id'] ?? '',
      image: map['image'] ?? '',

    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source));
}
