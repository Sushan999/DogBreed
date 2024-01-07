import 'dart:convert';

import 'package:http/http.dart';

class PredictedBreed {
  PredictedBreed({
    required this.avatar,
    required this.breed,
    required this.accuracy,
  });

  final String avatar;
  final String breed;
  final String accuracy;

  factory PredictedBreed.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'Avatar': String avater,
        'Breed': String breed,
        'Accuracy': String accuracy,
      } =>
        PredictedBreed(
          avatar: avater,
          breed: breed,
          accuracy: accuracy,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
  static List<PredictedBreed> listTopDog(List response) {
    final dogmodel = response.map((e) {
      return PredictedBreed(
          avatar: e['Avatar'], breed: e['Breed'], accuracy: e['Accuracy']);
    }).toList();
    return dogmodel;
  }
}
