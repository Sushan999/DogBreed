// // ignore_for_file: library_private_types_in_public_api
// import 'package:dogbreed/BreedListPage/models.dart';
// import 'package:dogbreed/breeds_UI.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class BreedListPage extends StatefulWidget {
//   const BreedListPage({super.key});

//   @override
//   _BreedsListPageState createState() => _BreedsListPageState();
// }

// class _BreedsListPageState extends State<BreedListPage> {
//   List<Breed> _breeds = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadBreeds();
//   }

//   Future<void> _loadBreeds() async {
//     var client = http.Client();
//     var uri = Uri.parse('http://10.10.11.138:8000/breed/breed_list/');
//     // final response = await http
//     //     .get(Uri.parse('http://192.168.254.198:8000/breed/breed_list/'));
//     var response = await client.get(uri);
//     setState(() {
//       _breeds = Breed.listDog(response);
//     });
//   }

//   Widget _buildBreedListTile(BuildContext context, int index) {
//     var breeds = _breeds[index];

//     return ListTile(
//       onTap: () => _navigateToBreedDetails(breeds, index),
//       leading: Hero(
//         tag: index,
//         child: CircleAvatar(
//           backgroundImage: NetworkImage(breeds.avatar),
//         ),
//       ),
//       title: Text(breeds.breed),
//       subtitle: Text(breeds.type),
//     );
//   }

//   void _navigateToBreedDetails(Breed friend, Object avatarTag) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (c) {
//           return BreedDetailPage(
//             dogBreed: friend.breed,
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget content;

//     if (_breeds.isEmpty) {
//       content = const Center(
//         child: CircularProgressIndicator(),
//       );
//     } else {
//       content = ListView.builder(
//         itemCount: _breeds.length,
//         itemBuilder: _buildBreedListTile,
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Identified Breeds'),
//         backgroundColor: Colors.lightGreen[200],
//       ),
//       body: content,
//     );
//   }
// }
// ignore_for_file: library_private_types_in_public_api
import 'package:dogbreed/BreedListPage/models.dart';
import 'package:dogbreed/breeds_UI.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BreedListPage extends StatefulWidget {
  const BreedListPage({super.key});

  @override
  _BreedsListPageState createState() => _BreedsListPageState();
}

class _BreedsListPageState extends State<BreedListPage> {
  List<Breed> _breeds = [];

  @override
  void initState() {
    super.initState();
    _loadBreeds();
  }

  Future<void> _loadBreeds() async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.254.198:8000/breed/breed_list/');
    // final response = await http
    //     .get(Uri.parse('http://192.168.254.198:8000/breed/breed_list/'));
    var response = await client.get(uri);
    setState(() {
      _breeds = Breed.listDog(response);
    });
  }

  Widget _buildBreedListTile(BuildContext context, int index) {
    var breeds = _breeds[index];

    return ListTile(
      onTap: () => _navigateToBreedDetails(breeds, index),
      leading: Hero(
        tag: index,
        child: CircleAvatar(
          backgroundImage: NetworkImage(breeds.avatar),
        ),
      ),
      title: Text(breeds.breed),
      subtitle: Text(breeds.type),
    );
  }

  void _navigateToBreedDetails(Breed friend, Object avatarTag) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
          return BreedDetailPage(
            dogBreed: friend.breed,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_breeds.isEmpty) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      content = ListView.builder(
        itemCount: _breeds.length,
        itemBuilder: _buildBreedListTile,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Identified Breeds'),
        backgroundColor: Colors.lightGreen[200],
      ),
      body: content,
    );
  }
}
