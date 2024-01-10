import 'package:camera/camera.dart';
import 'package:pupscan/models.dart';
import 'package:pupscan/PredictedPage/predicted_page_ui.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);
  final XFile picture;

  @override
  PreviewPagaeState createState() => PreviewPagaeState();
}

class PreviewPagaeState extends State<PreviewPage> {
  List<PredictedBreed> jsonList = [];
  bool isLoading = false;

  Future<void> predictEfficientNetDogBreed(File imageFile) async {
    // var client = http.Client();
    final uri =
        Uri.parse('http://192.168.254.198:8000/recognition/predict_from_both/');

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
        });
        // Successfully received the prediction, handle the respon
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
        print(response.statusCode.toString());
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _loadPage() {
    // Simulate loading delay
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Preview Page'),
          backgroundColor: Colors.lightGreen[200]),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(mainAxisSize: MainAxisSize.min, children: [
                Image.file(
                  File(widget.picture.path),
                  fit: BoxFit.cover,
                  height: 610,
                  width: 320,
                ),
                const SizedBox(height: 5),
                // Text(widget.picture.name),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    _loadPage();
                    // print(jsonList[0].accuracy);
                    File imageFile = File(widget.picture.path);
                    // CircularProgressIndicator();
                    await predictEfficientNetDogBreed(imageFile);
                    isLoading = false;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (c) {
                        return Dog_predicted_Page(
                          breeds: jsonList,
                          dogImage: imageFile,
                        );
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors
                          .lightGreen[200] // Set the background color to green
                      ),
                  child: const Text('Scan',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
                ),
              ]),
      ),
    );
  }

  Future<void> predicted() async {
    var client = http.Client();
    var uri =
        Uri.parse('http://192.168.254.198:8000/recognition/predict_from_both/');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      print("Success");
      print(response.body);
    }
  }
}
