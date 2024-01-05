import 'models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// for json response.
Future<DogModel> fetchDog() async {
  final response = await http.get(
      Uri.parse('http://192.168.254.198:8000/recognition/predict_from_both/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DogModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

// another method for list response.

Future<List<DogModel>> fetchDogDetail() async {
  final response = await http.get(
      Uri.parse('http://192.168.254.198:8000/recognition/predict_from_both/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    final json = jsonDecode(response.body) as List;
    final dogmodel = json.map((e) {
      return DogModel(
          model: e['Model'], breed: e['Breed'], accuracy: e['Accuracy']);
    }).toList();
    return dogmodel;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main() async {
  DogModel dogs = await fetchDog();
  print(dogs.breed);

  // List<DogModel> predicted_dogs = [];
  // predicted_dogs = await fetchDogDetail();
  // print(predicted_dogs.length);
}
