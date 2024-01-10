// ignore_for_file: prefer_interpolation_to_compose_strings, empty_constructor_bodies

import 'dart:convert';

import 'package:http/http.dart';

class DogDetail {
  DogDetail({
    required this.description,
    required this.breed,
    required this.character,
    required this.height,
    required this.weight,
    required this.akc,
    required this.life,
    required this.img,
    required this.img0,
    required this.img1,
    required this.type,
    required this.avatar,
  });

  final String breed;
  final String type;
  final String description;
  final String character;
  final String height;
  final String weight;
  final String akc;
  final String life;
  final String img;
  final String img0;
  final String img1;
  final String avatar;
  factory DogDetail.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'Description': String desc,
        'Breed': String breed,
        'Character': String char,
        'Height': String he,
        'Wight': String wi,
        'Life': String li,
        'Akc': String akc,
        'Img': String img,
        'Img0': String img0,
        'Img1': String img1,
        'avatar': String avatar,
      } =>
        DogDetail(
          description: desc,
          breed: breed,
          character: char,
          height: he,
          weight: wi,
          life: li,
          akc: akc,
          img: img,
          img0: img0,
          img1: img1,
          type: '',
          avatar: avatar,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }

  static List<DogDetail> listDog(Response response) {
    final json = jsonDecode('[' + response.body + ']') as List;
    final dogmodel = json.map((e) {
      return DogDetail(
          description: e['description'],
          character: e['character'],
          height: e['height'],
          weight: e['weight'],
          life: e['life_expentancy'],
          akc: e['akc_link'],
          img: e['image2'],
          img0: e['image0'],
          img1: e['image1'],
          breed: e['breed'],
          avatar: e['avatar'],
          type: e['type_id__type']);
    }).toList();
    return dogmodel;
  }
}

class DogDetailWithAccuracy extends DogDetail {
  DogDetailWithAccuracy(
      {required super.description,
      required super.breed,
      required super.character,
      required super.height,
      required super.weight,
      required super.akc,
      required super.life,
      required super.img,
      required super.img0,
      required super.img1,
      required super.type,
      required super.avatar,
      required this.accuracy})
      : super();

  final String accuracy;

  static List<DogDetailWithAccuracy> listTopDog(Response response) {
    final json = jsonDecode(response.body) as List;
    final dogmodel = json.map((e) {
      return DogDetailWithAccuracy(
          description: e['description'],
          character: e['character'],
          height: e['height'],
          weight: e['weight'],
          life: e['life_expentancy'],
          akc: e['akc_link'],
          img: e['image2'],
          img0: e['image0'],
          img1: e['image1'],
          breed: e['breed'],
          avatar: e['avatar'],
          type: e['type_id__type'],
          accuracy: e['accuracy']);
    }).toList();
    return dogmodel;
  }
}

class ListBreed {
  ListBreed({
    required this.avatar,
    required this.breed,
    required this.type,
    required this.id,
  });

  final String avatar;
  final String breed;
  final String type;
  final int id;

  factory ListBreed.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'avatar': String avater,
        'breed': String breed,
        'type': String type,
        'id': int id,
      } =>
        ListBreed(
          id: id,
          avatar: avater,
          breed: breed,
          type: type,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
  static List<ListBreed> listBreeds(List response) {
    final dogmodel = response.map((e) {
      return ListBreed(
          id: e['id'],
          avatar: e['avatar'],
          breed: e['breed'],
          type: e['type_id__type']);
    }).toList();
    return dogmodel;
  }
}

class PredictedBreed {
  PredictedBreed({
    required this.avatar,
    required this.breed,
    required this.accuracy,
    required this.id,
  });

  final String avatar;
  final String breed;
  final String accuracy;
  final int id;

  factory PredictedBreed.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'Avatar': String avater,
        'Breed': String breed,
        'Accuracy': String accuracy,
        'Id': int id,
      } =>
        PredictedBreed(
          id: id,
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
          id: e['id'],
          avatar: e['avatar'],
          breed: e['breed'],
          accuracy: e['accuracy']);
    }).toList();
    return dogmodel;
  }
}

class ChatMessage {
  final String text;
  final bool isBot;

  ChatMessage({required this.text, required this.isBot});
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'system': String text,
      } =>
        ChatMessage(
          text: text,
          isBot: true,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
