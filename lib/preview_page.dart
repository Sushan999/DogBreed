import 'package:camera/camera.dart';
import 'package:dogbreed/PredictedPage/model.dart';
import 'package:dogbreed/PredictedPage/predicted_page_ui.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);
  final XFile picture;

  @override
  PreviewPagaeState createState() => PreviewPagaeState();
}

class PreviewPagaeState extends State<PreviewPage> {
  List<PredictedBreed> jsonList = [];

  Future<void> predictEfficientNetDogBreed(File imageFile) async {
    // var client = http.Client();
    final uri =
        Uri.parse('http://10.10.11.138:8000/recognition/predict_from_both/');

    // Create a multipart request
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var json = await response.stream.bytesToString();
        var map = jsonDecode(json);

        setState(() {
          jsonList = PredictedBreed.listTopDog(map);
          ;
        });
        // Successfully received the prediction, handle the response
        print('Prediction: ${json.runtimeType}');
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
        print(response.statusCode.toString());
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
          Image.file(File(widget.picture.path),
              fit: BoxFit.cover, height: 250, width: 250),
          const SizedBox(height: 24),
          Text(widget.picture.name),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              File imageFile = File(widget.picture.path);
              await predictEfficientNetDogBreed(imageFile);
              Navigator.push(context, MaterialPageRoute(
                builder: (c) {
                  return Dog_predicted_Page(
                    breeds: jsonList,
                    dogImage: imageFile,
                  );
                },
              ));
              print(jsonList[0].breed);
            },
            child: const Text('Test'),
          ),
        ]),
      ),
    );
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
}
