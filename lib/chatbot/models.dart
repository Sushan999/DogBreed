import 'dart:convert';

import 'package:http/http.dart';

class Breed {
  Breed({
    required this.avatar,
    required this.breed,
    required this.type,
  });

  final String avatar;
  final String breed;
  final String type;

  factory Breed.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'Model': String avater,
        'Breed': String breed,
        'Accuracy': String type,
      } =>
        Breed(
          avatar: avater,
          breed: breed,
          type: type,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
  static List<Breed> listDog(Response response) {
    final json = jsonDecode(response.body) as List;
    final dogmodel = json.map((e) {
      return Breed(
          breed: e['breed'], avatar: e['avatar'], type: e['type_id__type']);
    }).toList();
    return dogmodel;
  }
}
