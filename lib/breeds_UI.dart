import 'package:flutter/material.dart';


class DogBreedsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dog Breeds App',
      home: DogBreedsPage(),
    );
  }
}

class DogBreedsPage extends StatelessWidget {
  // Sample list of dog breeds
  final List<String> dogBreeds = [
    'Labrador Retriever',
    'German Shepherd',
    'Golden Retriever',
    'Bulldog',
    'Beagle',
    'Poodle',
    'Dachshund',
    'Boxer',
    'Chihuahua',
    'Shih Tzu',
    'Siberian Husky',
    'Doberman Pinscher',
    'Rottweiler',
    'Great Dane',
    'Pug',
    'Australian Shepherd',
    'Shetland Sheepdog',
    'Border Collie',
    'Cavalier King Charles Spaniel',
    'Pomeranian',
    'Alaskan Malamute',
    'Basset Hound',
    'Saint Bernard',
    'French Bulldog',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Breeds'),
      ),
      body: ListView.builder(
        itemCount: dogBreeds.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0, // Add elevation for shadow
            margin: EdgeInsets.all(8.0), // Add margin for spacing
            child: ListTile(
              title: Text(dogBreeds[index]),
              // Navigate to a new page on item tap
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BreedDetailPage(dogBreed: dogBreeds[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BreedDetailPage extends StatelessWidget {
  final String dogBreed;

  BreedDetailPage({required this.dogBreed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breed Details'),
      ),
      body: Center(
        child: Text('Details for $dogBreed'),
      ),
    );
  }
}