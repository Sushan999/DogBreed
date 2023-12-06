import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  get http => null;

  void onButtonPressed() {
    // Add your custom functionality here
    // For example, you can navigate to another page or perform some action.
    print('Button Pressed!');
  }

  Future<void> predictEfficientNetDogBreed(File imageFile) async {
    final uri = Uri.parse('https://your-django-backend/predict_efficientnet_dog_bred/');

    // Create a multipart request
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Successfully received the prediction, handle the response
        print('Prediction: ${await response.stream.bytesToString()}');
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
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
              Image image = Image.file(File(picture.path));
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