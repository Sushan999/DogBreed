import 'package:dogbreed/PredictedPage/model.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// ignore: camel_case_types
class Dog_predicted_Page extends StatefulWidget {
  const Dog_predicted_Page(
      {super.key, required this.dogImage, required this.breeds});

  final File dogImage;
  final List<PredictedBreed> breeds;

  @override
  // ignore: library_private_types_in_public_api
  _Dog_predictState createState() => _Dog_predictState();
}

// ignore: camel_case_types
class _Dog_predictState extends State<Dog_predicted_Page> {
  List<PredictedBreed> identifiedBreeds = [];
  List colors = [Colors.red[400], Colors.orange[300], Colors.blue[200]];

  @override
  void initState() {
    super.initState();
    identifiedBreeds = widget.breeds;
  }

  Future<void> classifyImage(File image) async {}

  void breedsOntTap(String breedName) {
    // ignore: avoid_print
    print('Tapped breed: $breedName');
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
                  ? Image.file(
                      widget.dogImage,
                      height: 400,
                      width: 400,
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
                              onTap: () async {
                                breedsOntTap(breed.breed);
                              },

                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(breed.avatar),
                              ),
                              // leading: Image.network(
                              //   breed.avatar, // Path to the image asset
                              //   height: 60,
                              //   width: 60,
                              //   fit: BoxFit.cover,
                              // ),
                              title: Text(
                                breed.accuracy,
                                style: TextStyle(
                                    color: colors[index], fontSize: 15),
                                selectionColor: colors[index],
                              ),
                              subtitle: Text(breed.breed),
                            ));
                      },
                    )),
            ])));
  }
}
