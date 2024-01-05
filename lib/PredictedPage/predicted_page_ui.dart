import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Breed Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Dog_predict(
        dogImage: File('/dog_bot.jpg'),
      ),
    );
  }
}

// ignore: camel_case_types
class Dog_predict extends StatefulWidget {
  const Dog_predict({super.key, required this.dogImage});

  final File dogImage;

  @override
  // ignore: library_private_types_in_public_api
  _Dog_predictState createState() => _Dog_predictState();
}

// ignore: camel_case_types
class _Dog_predictState extends State<Dog_predict> {
  List<Map<String, dynamic>> identifiedBreeds = [];

  @override
  void initState() {
    super.initState();
    simulateClassification();
  }

  Future<void> classifyImage(File image) async {}

  void breedsOntTap(String breedName) {
    // ignore: avoid_print
    print('Tapped breed: $breedName');
  }

  void simulateClassification() {
    // Simulated response data - Replace this with your API response structure
    List<Map<String, dynamic>> mockResponse = [
      {
        'breedName': 'Labrador Retriever',
        'accuracy': 85,
        'image_path': '/dog_bot.jpg'
      },
      {
        'breedName': 'Golden Retriever',
        'accuracy': 75,
        'image_path': '/dog_bot.jpg'
      },
      {
        'breedName': 'German Shepherd',
        'accuracy': 70,
        'image_path': '/dog_bot.jpg'
      },
    ];

    // Update identifiedBreeds with the mock response after a delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        identifiedBreeds = mockResponse;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightGreen[300],
            title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dog Predictions"),
                ])),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              // ignore: unnecessary_null_comparison
              widget.dogImage != null
                  ? Image.asset(
                      'dog_bot.jpg',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(height: 200, width: 200),
              const SizedBox(height: 10),
              identifiedBreeds.isEmpty
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                      itemCount: identifiedBreeds.length,
                      itemBuilder: (BuildContext context, int index) {
                        final breed = identifiedBreeds[index];
                        return Container(
                            margin: const EdgeInsets.symmetric(vertical: 0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: ListTile(
                              onTap: () {
                                breedsOntTap(breed['breedName']);
                              },
                              leading: Image.asset(
                                breed['image_path'], // Path to the image asset
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                              title: Text('${breed['breedName']}'),
                              subtitle: Text('${breed['accuracy']}%'),
                            ));
                      },
                    )),
            ])));
  }
}
