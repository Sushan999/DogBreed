// ignore_for_file: library_private_types_in_public_api
import 'package:dogbreed/BreedListPage/models.dart';
import 'package:dogbreed/breeds_UI.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BreedListPage extends StatefulWidget {
  const BreedListPage({super.key});

  @override
  _FriendsListPageState createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<BreedListPage> {
  List<Breed> _breeds = [];

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.254.198:8000/breed/breed_list/');
    // final response = await http
    //     .get(Uri.parse('http://192.168.254.198:8000/breed/breed_list/'));
    var response = await client.get(uri);
    setState(() {
      _breeds = Breed.listDog(response);
    });
  }

  Widget _buildFriendListTile(BuildContext context, int index) {
    var breeds = _breeds[index];

    return ListTile(
      onTap: () => _navigateToFriendDetails(breeds, index),
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

  void _navigateToFriendDetails(Breed friend, Object avatarTag) {
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
        itemBuilder: _buildFriendListTile,
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
