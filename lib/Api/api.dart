import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pupscan/utils/models.dart';

class ApiCalls {
  static String address = '192.168.254.198';
  static Future<List<ListBreed>> loadBreeds() async {
    var client = http.Client();
    var uri = Uri.parse('http://$address:8000/breed/breed_list/');
    var response = await client.get(uri);

    return ListBreed.listBreeds(jsonDecode(response.body));
  }

  static Future<DogDetail> loadDetail(int id) async {
    final response = await http.post(
        Uri.parse('http://$address:8000/breed/breed_detail/'),
        body: {'index': id.toString()});

    return DogDetail.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<List<PredictedBreed>> predictDogBreed(File imageFile) async {
    // var client = http.Client();
    final uri =
        Uri.parse('http://$address:8000/recognition/predict_from_both/');

    // Create a multipart request
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var json = await response.stream.bytesToString();
        var map = jsonDecode(json);

        return PredictedBreed.listTopDog(map);
        // Successfully received the prediction, handle the respon
      } else {
        // Handle errors
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<ChatMessage> botMessage(
      String inputstring, String breed) async {
    final response = await http.post(
        Uri.parse('http://$address:8000/chatbot/get_message/'),
        body: {'input_string': inputstring, 'breed': breed});
    return ChatMessage.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}
