import 'dart:convert';
import 'package:pupscan/utils/models.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pupscan/DetailPage/result_screen.dart';

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

  Future<DogDetail> _loadDetail(int id) async {
    final response = await http.post(
        Uri.parse('http://192.168.254.198:8000/breed/breed_detail/'),
        body: {'index': id.toString()});

    return DogDetail.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<void> classifyImage(File image) async {}

  void breedsOntTap(BuildContext context, PredictedBreed breed) async {
    DogDetail clickedDog = await _loadDetail(breed.id);
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
          return ResultScreen(breed: clickedDog);
          // return ResultScreen(id: breedIndex);
        },
      ),
    );
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

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text('Top Predictions',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400))),
              ),

              identifiedBreeds.isEmpty
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                      itemCount: widget.breeds.length,
                      itemBuilder: (BuildContext context, int index) {
                        final breed = widget.breeds[index];
                        return Container(
                            margin: const EdgeInsets.symmetric(vertical: 0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: ListTile(
                              onTap: () async {
                                breedsOntTap(context, breed);
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(breed.avatar),
                              ),
                              title: Text(
                                '${breed.accuracy}%',
                                style: TextStyle(
                                    color: colors[index], fontSize: 20),
                                selectionColor: colors[index],
                              ),
                              subtitle: Text(
                                breed.breed,
                                style: const TextStyle(fontSize: 17),
                              ),
                            ));
                      },
                    )),
            ])));
  }
}
