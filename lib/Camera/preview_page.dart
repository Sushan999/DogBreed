import 'package:camera/camera.dart';
import 'package:pupscan/Api/api.dart';
import 'package:pupscan/utils/models.dart';
import 'package:pupscan/PredictedPage/predicted_page_ui.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);
  final XFile picture;

  @override
  PreviewPagaeState createState() => PreviewPagaeState();
}

class PreviewPagaeState extends State<PreviewPage> {
  List<PredictedBreed> jsonList = [];
  bool isLoading = false;

  void _loadPage() {
    // Simulate loading delay
    setState(() {
      isLoading = true;
    });
  }

  Future<void> classifyImage(File imgeFile) async {
    List<PredictedBreed> predictedList =
        await ApiCalls.predictDogBreed(imgeFile);
    setState(() {
      jsonList = predictedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Preview Page'),
          backgroundColor: Colors.lightGreen[200]),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.cyan,
                      color: Colors.red,
                      strokeWidth: 5,
                    ),
                  ),
                  Text('Predicting...')
                ],
              ),
            )
          : Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
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

                    await classifyImage(imageFile);
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
}
