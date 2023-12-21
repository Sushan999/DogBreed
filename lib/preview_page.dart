import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'dart:convert';
import 'package:http/http.dart' as http;

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  void onButtonPressed() {
    // Add your custom functionality here
    // For example, you can navigate to another page or perform some action.
    print('Button Pressed!');
  }

  Future<String> predictEfficientNetDogBreed(File imageFile) async {
    // var client = http.Client();
    final uri =
        Uri.parse('http://10.10.11.186:8000/recognition/predict_from_both/');

    // Create a multipart request
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var json = await response.stream.bytesToString();
        // Successfully received the prediction, handle the response
        print('Prediction: ${json}');
        return json;
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
        return response.statusCode.toString();
      }
    } catch (e) {
      print('Error: $e');
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
          Text(picture.name),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              File imageFile = File(picture.path);
              var json = predictEfficientNetDogBreed(imageFile);
              // Add your button's functionality here
              // For example, you can navigate to another page or perform some action.
            },
            child: Text('Test'),
          ),
        ]),
      ),
    );
  }
}

Future<void> predicted() async {
  var client = http.Client();
  var uri =
      Uri.parse('http://10.10.11.186:8000/recognition/predict_from_both/');
  var response = await client.get(uri);
  if (response.statusCode == 200) {
    var json = response.body;
    print("Success");
    print(response.body);
  }
}
